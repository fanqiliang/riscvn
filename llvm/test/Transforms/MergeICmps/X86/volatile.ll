; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=mergeicmps -verify-dom-info -mtriple=x86_64-unknown-unknown -S | FileCheck %s

%S = type { i32, i32 }

define zeroext i1 @opeq(
; CHECK-LABEL: @opeq(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[A:%.*]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[B:%.*]], align 4
; CHECK-NEXT:    [[CMP_I:%.*]] = icmp eq i32 [[TMP0]], [[TMP1]]
; CHECK-NEXT:    br i1 [[CMP_I]], label [[LAND_RHS_I:%.*]], label [[OPEQ1_EXIT:%.*]]
; CHECK:       land.rhs.i:
; CHECK-NEXT:    [[SECOND_I:%.*]] = getelementptr inbounds [[S:%.*]], ptr [[A]], i64 0, i32 1
; CHECK-NEXT:    [[TMP2:%.*]] = load volatile i32, ptr [[SECOND_I]], align 4
; CHECK-NEXT:    [[SECOND2_I:%.*]] = getelementptr inbounds [[S]], ptr [[B]], i64 0, i32 1
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr [[SECOND2_I]], align 4
; CHECK-NEXT:    [[CMP3_I:%.*]] = icmp eq i32 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    br label [[OPEQ1_EXIT]]
; CHECK:       opeq1.exit:
; CHECK-NEXT:    [[TMP4:%.*]] = phi i1 [ false, [[ENTRY:%.*]] ], [ [[CMP3_I]], [[LAND_RHS_I]] ]
; CHECK-NEXT:    ret i1 [[TMP4]]
;
  ptr nocapture readonly dereferenceable(8) %a,
  ptr nocapture readonly dereferenceable(8) %b) local_unnamed_addr #0 {
entry:
  %0 = load i32, ptr %a, align 4
  %1 = load i32, ptr %b, align 4
  %cmp.i = icmp eq i32 %0, %1
  br i1 %cmp.i, label %land.rhs.i, label %opeq1.exit

land.rhs.i:
  %second.i = getelementptr inbounds %S, ptr %a, i64 0, i32 1
  %2 = load volatile i32, ptr %second.i, align 4
  %second2.i = getelementptr inbounds %S, ptr %b, i64 0, i32 1
  %3 = load i32, ptr %second2.i, align 4
  %cmp3.i = icmp eq i32 %2, %3
  br label %opeq1.exit

opeq1.exit:
  %4 = phi i1 [ false, %entry ], [ %cmp3.i, %land.rhs.i ]
  ret i1 %4
}