; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve2 -force-streaming-compatible  < %s | FileCheck %s --check-prefix=SVE2
; RUN: llc -mattr=+sme -force-streaming < %s | FileCheck %s --check-prefix=SVE2
; RUN: llc -force-streaming-compatible < %s | FileCheck %s --check-prefix=NONEON-NOSVE

target triple = "aarch64-unknown-linux-gnu"

;
; MUL
;

define <2 x i64> @mul_v2i64(<2 x i64> %op1, <2 x i64> %op2) {
; SVE2-LABEL: mul_v2i64:
; SVE2:       // %bb.0:
; SVE2-NEXT:    // kill: def $q0 killed $q0 def $z0
; SVE2-NEXT:    // kill: def $q1 killed $q1 def $z1
; SVE2-NEXT:    mul z0.d, z0.d, z1.d
; SVE2-NEXT:    // kill: def $q0 killed $q0 killed $z0
; SVE2-NEXT:    ret
;
; NONEON-NOSVE-LABEL: mul_v2i64:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    stp q0, q1, [sp, #-48]!
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 48
; NONEON-NOSVE-NEXT:    ldp x9, x10, [sp]
; NONEON-NOSVE-NEXT:    ldr x8, [sp, #24]
; NONEON-NOSVE-NEXT:    mul x11, x10, x8
; NONEON-NOSVE-NEXT:    ldr x8, [sp, #16]
; NONEON-NOSVE-NEXT:    mul x8, x9, x8
; NONEON-NOSVE-NEXT:    stp x8, x11, [sp, #32]
; NONEON-NOSVE-NEXT:    ldr q0, [sp, #32]
; NONEON-NOSVE-NEXT:    add sp, sp, #48
; NONEON-NOSVE-NEXT:    ret
  %res = mul <2 x i64> %op1, %op2
  ret <2 x i64> %res
}