// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 4
// REQUIRES: amdgpu-registered-target
// RUN: %clang_cc1 %s -emit-llvm -O0 -o - \
// RUN:   -triple=amdgcn-amd-amdhsa | FileCheck %s

// CHECK-LABEL: define dso_local void @_Z25test_memory_fence_successv(
// CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    fence syncscope("workgroup") seq_cst
// CHECK-NEXT:    fence syncscope("agent") acquire
// CHECK-NEXT:    fence seq_cst
// CHECK-NEXT:    fence syncscope("agent") acq_rel
// CHECK-NEXT:    fence syncscope("workgroup") release
// CHECK-NEXT:    ret void
//
void test_memory_fence_success() {

  __builtin_amdgcn_fence(__ATOMIC_SEQ_CST, "workgroup");

  __builtin_amdgcn_fence(__ATOMIC_ACQUIRE, "agent");

  __builtin_amdgcn_fence(__ATOMIC_SEQ_CST, "");

  __builtin_amdgcn_fence(4, "agent");

  __builtin_amdgcn_fence(3, "workgroup");
}

// CHECK-LABEL: define dso_local void @_Z10test_localv(
// CHECK-SAME: ) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    fence syncscope("workgroup") seq_cst, !mmra [[META3:![0-9]+]]
// CHECK-NEXT:    fence syncscope("agent") acquire, !mmra [[META3]]
// CHECK-NEXT:    fence seq_cst, !mmra [[META3]]
// CHECK-NEXT:    fence syncscope("agent") acq_rel, !mmra [[META3]]
// CHECK-NEXT:    fence syncscope("workgroup") release, !mmra [[META3]]
// CHECK-NEXT:    ret void
//
void test_local() {
  __builtin_amdgcn_fence( __ATOMIC_SEQ_CST, "workgroup", "local");

  __builtin_amdgcn_fence(__ATOMIC_ACQUIRE, "agent", "local");

  __builtin_amdgcn_fence(__ATOMIC_SEQ_CST, "", "local");

  __builtin_amdgcn_fence(4, "agent", "local");

  __builtin_amdgcn_fence(3, "workgroup", "local");
}


// CHECK-LABEL: define dso_local void @_Z11test_globalv(
// CHECK-SAME: ) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    fence syncscope("workgroup") seq_cst, !mmra [[META4:![0-9]+]]
// CHECK-NEXT:    fence syncscope("agent") acquire, !mmra [[META4]]
// CHECK-NEXT:    fence seq_cst, !mmra [[META4]]
// CHECK-NEXT:    fence syncscope("agent") acq_rel, !mmra [[META4]]
// CHECK-NEXT:    fence syncscope("workgroup") release, !mmra [[META4]]
// CHECK-NEXT:    ret void
//
void test_global() {
  __builtin_amdgcn_fence( __ATOMIC_SEQ_CST, "workgroup", "global");

  __builtin_amdgcn_fence(__ATOMIC_ACQUIRE, "agent", "global");

  __builtin_amdgcn_fence(__ATOMIC_SEQ_CST, "", "global");

  __builtin_amdgcn_fence(4, "agent", "global");

  __builtin_amdgcn_fence(3, "workgroup", "global");
}

// CHECK-LABEL: define dso_local void @_Z10test_imagev(
// CHECK-SAME: ) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    fence syncscope("workgroup") seq_cst, !mmra [[META3]]
// CHECK-NEXT:    fence syncscope("agent") acquire, !mmra [[META3]]
// CHECK-NEXT:    fence seq_cst, !mmra [[META3]]
// CHECK-NEXT:    fence syncscope("agent") acq_rel, !mmra [[META3]]
// CHECK-NEXT:    fence syncscope("workgroup") release, !mmra [[META3]]
// CHECK-NEXT:    ret void
//
void test_image() {
  __builtin_amdgcn_fence( __ATOMIC_SEQ_CST, "workgroup", "local");

  __builtin_amdgcn_fence(__ATOMIC_ACQUIRE, "agent", "local");

  __builtin_amdgcn_fence(__ATOMIC_SEQ_CST, "", "local");

  __builtin_amdgcn_fence(4, "agent", "local");

  __builtin_amdgcn_fence(3, "workgroup", "local");
}

// CHECK-LABEL: define dso_local void @_Z10test_mixedv(
// CHECK-SAME: ) #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    fence syncscope("workgroup") seq_cst, !mmra [[META5:![0-9]+]]
// CHECK-NEXT:    fence syncscope("workgroup") seq_cst, !mmra [[META5]]
// CHECK-NEXT:    ret void
//
void test_mixed() {
  __builtin_amdgcn_fence( __ATOMIC_SEQ_CST, "workgroup", "local", "global");
  __builtin_amdgcn_fence( __ATOMIC_SEQ_CST, "workgroup", "local", "local", "global", "local", "local");
}
//.
// CHECK: [[META3]] = !{!"amdgpu-as", !"local"}
// CHECK: [[META4]] = !{!"amdgpu-as", !"global"}
// CHECK: [[META5]] = !{[[META4]], [[META3]]}
//.