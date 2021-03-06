Require Export D.



(** **** Exercise: 4 stars (hoare_asgn_wrong)  *)
(** The assignment rule looks backward to almost everyone the first
    time they see it.  If it still seems backward to you, it may help
    to think a little about alternative "forward" rules.  Here is a
    seemingly natural one:
      ------------------------------ (hoare_asgn_wrong)
      {{ True }} X ::= a {{ X = a }}
    Give a counterexample showing that this rule is incorrect
    (informally). Hint: The rule universally quantifies over the
    arithmetic expression [a], and your counterexample needs to
    exhibit an [a] for which the rule doesn't work. *)

Theorem hoare_asgn_wrong:
  exists a, ~ {{ fun st => True }} X ::= a {{ fun st => st X = aeval st a}}.
Proof.
  exists (APlus (AId X) (ANum 1)). unfold not. intros Hcontra.
  simpl in Hcontra. unfold hoare_triple in Hcontra.
  assert ((t_update empty_state X 1) X = (t_update empty_state X 1) X + 1).
  { eapply Hcontra. apply E_Ass. reflexivity. reflexivity. }
  simpl in H. inversion H.
Qed.