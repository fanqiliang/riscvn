; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

define internal fastcc i32 @term_SharingList(ptr %Term, ptr %List) nounwind {
; CGSCC: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@term_SharingList
; CGSCC-SAME: () #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    br i1 false, label [[BB:%.*]], label [[BB5:%.*]]
; CGSCC:       bb:
; CGSCC-NEXT:    unreachable
; CGSCC:       bb5:
; CGSCC-NEXT:    ret i32 undef
;
entry:
  br i1 false, label %bb, label %bb5

bb:		; preds = %entry
  %0 = call fastcc i32 @term_SharingList( ptr null, ptr %List ) nounwind		; <i32> [#uses=0]
  unreachable

bb5:		; preds = %entry
  ret i32 0
}

define i32 @term_Sharing(ptr %Term) nounwind {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@term_Sharing
; CHECK-SAME: (ptr nocapture nofree readnone [[TERM:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[BB_I:%.*]], label [[BB14:%.*]]
; CHECK:       bb.i:
; CHECK-NEXT:    unreachable
; CHECK:       bb14:
; CHECK-NEXT:    ret i32 0
;
entry:
  br i1 false, label %bb.i, label %bb14

bb.i:		; preds = %entry
  %0 = call fastcc i32 @term_SharingList( ptr null, ptr null ) nounwind		; <i32> [#uses=0]
  ret i32 1

bb14:		; preds = %entry
  ret i32 0
}
;.
; TUNIT: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
;.
; CGSCC: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; TUNIT: {{.*}}