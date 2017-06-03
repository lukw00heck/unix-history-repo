; REQUIRES: asserts
; NOTE: The flag -reverse-iterate is present only in a +Asserts build.
; Hence, this test has been split from condprop.ll to test with -reverse-iterate.
; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -print-predicateinfo -analyze -reverse-iterate  < %s 2>&1 | FileCheck %s

@a = external global i32		; <i32*> [#uses=7]

define i32 @test1() nounwind {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i32 [[TMP0]], 4
; CHECK-NEXT:    br i1 [[TMP1]], label [[BB:%.*]], label [[BB1:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    br label [[BB8:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i32 [[TMP2]], 5
; CHECK-NEXT:    br i1 [[TMP3]], label [[BB2:%.*]], label [[BB3:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    br label [[BB8]]
; CHECK:       bb3:
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[TMP4]], 4
; CHECK-NEXT:    br i1 [[TMP5]], label [[BB4:%.*]], label [[BB5:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[TMP7:%.*]] = add i32 [[TMP6]], 5
; CHECK-NEXT:    br label [[BB8]]
; CHECK:       bb5:
; CHECK-NEXT:    [[TMP8:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[TMP8]], 5
; CHECK-NEXT:    br i1 [[TMP9]], label [[BB6:%.*]], label [[BB7:%.*]]
; CHECK:       bb6:
; CHECK-NEXT:    [[TMP10:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[TMP11:%.*]] = add i32 [[TMP10]], 4
; CHECK-NEXT:    br label [[BB8]]
; CHECK:       bb7:
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    br label [[BB8]]
; CHECK:       bb8:
; CHECK-NEXT:    [[DOT0:%.*]] = phi i32 [ [[TMP12]], [[BB7]] ], [ [[TMP11]], [[BB6]] ], [ [[TMP7]], [[BB4]] ], [ 4, [[BB2]] ], [ 5, [[BB]] ]
; CHECK-NEXT:    br label [[RETURN:%.*]]
; CHECK:       return:
; CHECK-NEXT:    ret i32 [[DOT0]]
;
entry:
  %0 = load i32, i32* @a, align 4
  %1 = icmp eq i32 %0, 4
  br i1 %1, label %bb, label %bb1

bb:		; preds = %entry
  br label %bb8

bb1:		; preds = %entry
  %2 = load i32, i32* @a, align 4
  %3 = icmp eq i32 %2, 5
  br i1 %3, label %bb2, label %bb3

bb2:		; preds = %bb1
  br label %bb8

bb3:		; preds = %bb1
  %4 = load i32, i32* @a, align 4
  %5 = icmp eq i32 %4, 4
  br i1 %5, label %bb4, label %bb5

bb4:		; preds = %bb3
  %6 = load i32, i32* @a, align 4
  %7 = add i32 %6, 5
  br label %bb8

bb5:		; preds = %bb3
  %8 = load i32, i32* @a, align 4
  %9 = icmp eq i32 %8, 5
  br i1 %9, label %bb6, label %bb7

bb6:		; preds = %bb5
  %10 = load i32, i32* @a, align 4
  %11 = add i32 %10, 4
  br label %bb8

bb7:		; preds = %bb5
  %12 = load i32, i32* @a, align 4
  br label %bb8

bb8:		; preds = %bb7, %bb6, %bb4, %bb2, %bb
  %.0 = phi i32 [ %12, %bb7 ], [ %11, %bb6 ], [ %7, %bb4 ], [ 4, %bb2 ], [ 5, %bb ]
  br label %return

return:		; preds = %bb8
  ret i32 %.0
}

declare void @foo(i1)
declare void @bar(i32)

define void @test3(i32 %x, i32 %y) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[XZ:%.*]] = icmp eq i32 [[X:%.*]], 0
; CHECK-NEXT:    [[YZ:%.*]] = icmp eq i32 [[Y:%.*]], 0
; CHECK-NEXT:    [[Z:%.*]] = and i1 [[XZ]], [[YZ]]
; CHECK:         [[X_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X]])
; CHECK:         [[Y_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[Y]])
; CHECK:         [[XZ_0:%.*]] = call i1 @llvm.ssa.copy.i1(i1 [[XZ]])
; CHECK:         [[YZ_0:%.*]] = call i1 @llvm.ssa.copy.i1(i1 [[YZ]])
; CHECK:         [[Z_0:%.*]] = call i1 @llvm.ssa.copy.i1(i1 [[Z]])
; CHECK-NEXT:    br i1 [[Z]], label [[BOTH_ZERO:%.*]], label [[NOPE:%.*]]
; CHECK:       both_zero:
; CHECK-NEXT:    call void @foo(i1 [[XZ_0]])
; CHECK-NEXT:    call void @foo(i1 [[YZ_0]])
; CHECK-NEXT:    call void @bar(i32 [[X_0]])
; CHECK-NEXT:    call void @bar(i32 [[Y_0]])
; CHECK-NEXT:    ret void
; CHECK:       nope:
; CHECK-NEXT:    call void @foo(i1 [[Z_0]])
; CHECK-NEXT:    ret void
;
  %xz = icmp eq i32 %x, 0
  %yz = icmp eq i32 %y, 0
  %z = and i1 %xz, %yz
  br i1 %z, label %both_zero, label %nope
both_zero:
  call void @foo(i1 %xz)
  call void @foo(i1 %yz)
  call void @bar(i32 %x)
  call void @bar(i32 %y)
  ret void
nope:
  call void @foo(i1 %z)
  ret void
}

define void @test4(i1 %b, i32 %x) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    br i1 [[B:%.*]], label [[SW:%.*]], label [[CASE3:%.*]]
; CHECK:       sw:
; CHECK:         i32 0, label [[CASE0:%.*]]
; CHECK-NEXT:    i32 1, label [[CASE1:%.*]]
; CHECK-NEXT:    i32 2, label [[CASE0]]
; CHECK-NEXT:    i32 3, label [[CASE3]]
; CHECK-NEXT:    i32 4, label [[DEFAULT:%.*]]
; CHECK-NEXT:    ] Edge: [label [[SW]],label %case1] }
; CHECK-NEXT:    [[X_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X:%.*]])
; CHECK-NEXT:    switch i32 [[X]], label [[DEFAULT]] [
; CHECK-NEXT:    i32 0, label [[CASE0]]
; CHECK-NEXT:    i32 1, label [[CASE1]]
; CHECK-NEXT:    i32 2, label [[CASE0]]
; CHECK-NEXT:    i32 3, label [[CASE3]]
; CHECK-NEXT:    i32 4, label [[DEFAULT]]
; CHECK-NEXT:    ]
; CHECK:       default:
; CHECK-NEXT:    call void @bar(i32 [[X]])
; CHECK-NEXT:    ret void
; CHECK:       case0:
; CHECK-NEXT:    call void @bar(i32 [[X]])
; CHECK-NEXT:    ret void
; CHECK:       case1:
; CHECK-NEXT:    call void @bar(i32 [[X_0]])
; CHECK-NEXT:    ret void
; CHECK:       case3:
; CHECK-NEXT:    call void @bar(i32 [[X]])
; CHECK-NEXT:    ret void
;
  br i1 %b, label %sw, label %case3
sw:
  switch i32 %x, label %default [
  i32 0, label %case0
  i32 1, label %case1
  i32 2, label %case0
  i32 3, label %case3
  i32 4, label %default
  ]
default:
  call void @bar(i32 %x)
  ret void
case0:
  call void @bar(i32 %x)
  ret void
case1:
  call void @bar(i32 %x)
  ret void
case3:
  call void @bar(i32 %x)
  ret void
}

define i1 @test5(i32 %x, i32 %y) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], [[Y:%.*]]
; CHECK:         [[X_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X]])
; CHECK:         [[X_1:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X]])
; CHECK:         [[Y_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[Y]])
; CHECK:         [[Y_1:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[Y]])
; CHECK-NEXT:    br i1 [[CMP]], label [[SAME:%.*]], label [[DIFFERENT:%.*]]
; CHECK:       same:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ne i32 [[X_0]], [[Y_0]]
; CHECK-NEXT:    ret i1 [[CMP2]]
; CHECK:       different:
; CHECK-NEXT:    [[CMP3:%.*]] = icmp eq i32 [[X_1]], [[Y_1]]
; CHECK-NEXT:    ret i1 [[CMP3]]
;
  %cmp = icmp eq i32 %x, %y
  br i1 %cmp, label %same, label %different

same:
  %cmp2 = icmp ne i32 %x, %y
  ret i1 %cmp2

different:
  %cmp3 = icmp eq i32 %x, %y
  ret i1 %cmp3
}

define i1 @test6(i32 %x, i32 %y) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ne i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X]], [[Y]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp eq i32 [[X]], [[Y]]
; CHECK-NEXT:    br i1 [[CMP]], label [[SAME:%.*]], label [[DIFFERENT:%.*]]
; CHECK:       same:
; CHECK-NEXT:    ret i1 [[CMP2]]
; CHECK:       different:
; CHECK-NEXT:    ret i1 [[CMP3]]
;
  %cmp2 = icmp ne i32 %x, %y
  %cmp = icmp eq i32 %x, %y
  %cmp3 = icmp eq i32 %x, %y
  br i1 %cmp, label %same, label %different

same:
  ret i1 %cmp2

different:
  ret i1 %cmp3
}

define i1 @test6_fp(float %x, float %y) {
; CHECK-LABEL: @test6_fp(
; CHECK-NEXT:    [[CMP2:%.*]] = fcmp une float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp oeq float [[X]], [[Y]]
; CHECK-NEXT:    [[CMP3:%.*]] = fcmp oeq float [[X]], [[Y]]
; CHECK-NEXT:    br i1 [[CMP]], label [[SAME:%.*]], label [[DIFFERENT:%.*]]
; CHECK:       same:
; CHECK-NEXT:    ret i1 [[CMP2]]
; CHECK:       different:
; CHECK-NEXT:    ret i1 [[CMP3]]
;
  %cmp2 = fcmp une float %x, %y
  %cmp = fcmp oeq float %x, %y
  %cmp3 = fcmp oeq float  %x, %y
  br i1 %cmp, label %same, label %different

same:
  ret i1 %cmp2

different:
  ret i1 %cmp3
}

define i1 @test7(i32 %x, i32 %y) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[X:%.*]], [[Y:%.*]]
; CHECK:         [[X_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X]])
; CHECK:         [[X_1:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X]])
; CHECK:         [[Y_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[Y]])
; CHECK:         [[Y_1:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[Y]])
; CHECK-NEXT:    br i1 [[CMP]], label [[SAME:%.*]], label [[DIFFERENT:%.*]]
; CHECK:       same:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[X_0]], [[Y_0]]
; CHECK-NEXT:    ret i1 [[CMP2]]
; CHECK:       different:
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[X_1]], [[Y_1]]
; CHECK-NEXT:    ret i1 [[CMP3]]
;
  %cmp = icmp sgt i32 %x, %y
  br i1 %cmp, label %same, label %different

same:
  %cmp2 = icmp sle i32 %x, %y
  ret i1 %cmp2

different:
  %cmp3 = icmp sgt i32 %x, %y
  ret i1 %cmp3
}

define i1 @test7_fp(float %x, float %y) {
; CHECK-LABEL: @test7_fp(
; CHECK-NEXT:    [[CMP:%.*]] = fcmp ogt float [[X:%.*]], [[Y:%.*]]
; CHECK:         [[X_0:%.*]] = call float @llvm.ssa.copy.f32(float [[X]])
; CHECK:         [[X_1:%.*]] = call float @llvm.ssa.copy.f32(float [[X]])
; CHECK:         [[Y_0:%.*]] = call float @llvm.ssa.copy.f32(float [[Y]])
; CHECK:         [[Y_1:%.*]] = call float @llvm.ssa.copy.f32(float [[Y]])
; CHECK-NEXT:    br i1 [[CMP]], label [[SAME:%.*]], label [[DIFFERENT:%.*]]
; CHECK:       same:
; CHECK-NEXT:    [[CMP2:%.*]] = fcmp ule float [[X_0]], [[Y_0]]
; CHECK-NEXT:    ret i1 [[CMP2]]
; CHECK:       different:
; CHECK-NEXT:    [[CMP3:%.*]] = fcmp ogt float [[X_1]], [[Y_1]]
; CHECK-NEXT:    ret i1 [[CMP3]]
;
  %cmp = fcmp ogt float %x, %y
  br i1 %cmp, label %same, label %different

same:
  %cmp2 = fcmp ule float %x, %y
  ret i1 %cmp2

different:
  %cmp3 = fcmp ogt float %x, %y
  ret i1 %cmp3
}

define i1 @test8(i32 %x, i32 %y) {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[X]], [[Y]]
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[X]], [[Y]]
; CHECK-NEXT:    br i1 [[CMP]], label [[SAME:%.*]], label [[DIFFERENT:%.*]]
; CHECK:       same:
; CHECK-NEXT:    ret i1 [[CMP2]]
; CHECK:       different:
; CHECK-NEXT:    ret i1 [[CMP3]]
;
  %cmp2 = icmp sle i32 %x, %y
  %cmp = icmp sgt i32 %x, %y
  %cmp3 = icmp sgt i32 %x, %y
  br i1 %cmp, label %same, label %different

same:
  ret i1 %cmp2

different:
  ret i1 %cmp3
}

define i1 @test8_fp(float %x, float %y) {
; CHECK-LABEL: @test8_fp(
; CHECK-NEXT:    [[CMP2:%.*]] = fcmp ule float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = fcmp ogt float [[X]], [[Y]]
; CHECK-NEXT:    [[CMP3:%.*]] = fcmp ogt float [[X]], [[Y]]
; CHECK-NEXT:    br i1 [[CMP]], label [[SAME:%.*]], label [[DIFFERENT:%.*]]
; CHECK:       same:
; CHECK-NEXT:    ret i1 [[CMP2]]
; CHECK:       different:
; CHECK-NEXT:    ret i1 [[CMP3]]
;
  %cmp2 = fcmp ule float %x, %y
  %cmp = fcmp ogt float %x, %y
  %cmp3 = fcmp ogt float %x, %y
  br i1 %cmp, label %same, label %different

same:
  ret i1 %cmp2

different:
  ret i1 %cmp3
}

define i32 @test9(i32 %i, i32 %j) {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[I:%.*]], [[J:%.*]]
; CHECK:         [[I_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[I]])
; CHECK:         [[J_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[J]])
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[RET:%.*]]
; CHECK:       cond_true:
; CHECK-NEXT:    [[DIFF:%.*]] = sub i32 [[I_0]], [[J_0]]
; CHECK-NEXT:    ret i32 [[DIFF]]
; CHECK:       ret:
; CHECK-NEXT:    ret i32 5
;
  %cmp = icmp eq i32 %i, %j
  br i1 %cmp, label %cond_true, label %ret

cond_true:
  %diff = sub i32 %i, %j
  ret i32 %diff

ret:
  ret i32 5
}

define i32 @test10(i32 %j, i32 %i) {
; CHECK-LABEL: @test10(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[I:%.*]], [[J:%.*]]
; CHECK:         [[J_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[J]])
; CHECK:         [[I_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[I]])
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[RET:%.*]]
; CHECK:       cond_true:
; CHECK-NEXT:    [[DIFF:%.*]] = sub i32 [[I_0]], [[J_0]]
; CHECK-NEXT:    ret i32 [[DIFF]]
; CHECK:       ret:
; CHECK-NEXT:    ret i32 5
;
  %cmp = icmp eq i32 %i, %j
  br i1 %cmp, label %cond_true, label %ret

cond_true:
  %diff = sub i32 %i, %j
  ret i32 %diff

ret:
  ret i32 5
}

declare i32 @yogibar()

define i32 @test11(i32 %x) {
; CHECK-LABEL: @test11(
; CHECK-NEXT:    [[V0:%.*]] = call i32 @yogibar()
; CHECK-NEXT:    [[V1:%.*]] = call i32 @yogibar()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[V0]], [[V1]]
; CHECK:         [[V0_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[V0]])
; CHECK:         [[V1_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[V1]])
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[NEXT:%.*]]
; CHECK:       cond_true:
; CHECK-NEXT:    ret i32 [[V1_0]]
; CHECK:       next:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[X:%.*]], [[V0_0]]
; CHECK:         [[V0_0_1:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[V0_0]])
; CHECK-NEXT:    br i1 [[CMP2]], label [[COND_TRUE2:%.*]], label [[NEXT2:%.*]]
; CHECK:       cond_true2:
; CHECK-NEXT:    ret i32 [[V0_0_1]]
; CHECK:       next2:
; CHECK-NEXT:    ret i32 0
;
  %v0 = call i32 @yogibar()
  %v1 = call i32 @yogibar()
  %cmp = icmp eq i32 %v0, %v1
  br i1 %cmp, label %cond_true, label %next

cond_true:
  ret i32 %v1

next:
  %cmp2 = icmp eq i32 %x, %v0
  br i1 %cmp2, label %cond_true2, label %next2

cond_true2:
  ret i32 %v0

next2:
  ret i32 0
}

define i32 @test12(i32 %x) {
; CHECK-LABEL: @test12(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X:%.*]], 0
; CHECK:         [[X_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X]])
; CHECK:         [[X_1:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X]])
; CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
; CHECK:       cond_true:
; CHECK-NEXT:    br label [[RET:%.*]]
; CHECK:       cond_false:
; CHECK-NEXT:    br label [[RET]]
; CHECK:       ret:
; CHECK-NEXT:    [[RES:%.*]] = phi i32 [ [[X_0]], [[COND_TRUE]] ], [ [[X_1]], [[COND_FALSE]] ]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %cmp = icmp eq i32 %x, 0
  br i1 %cmp, label %cond_true, label %cond_false

cond_true:
  br label %ret

cond_false:
  br label %ret

ret:
  %res = phi i32 [ %x, %cond_true ], [ %x, %cond_false ]
  ret i32 %res
}
