|% 
+$  texteditor-action
  $%
    [%create-project project=@tas]
    [%delete-project project=@tas]
    [%create-note project=@tas note=@tas contents=@t]
    [%delete-note project=@tas note=@tas]
    [%create-note-remote project=@tas note=@tas contents=@t who=@p]
    [%delete-note-remote project=@tas note=@tas who=@p]
    [%give-permissions project=@tas who=@p]
    [%revoke-permissions project=@tas who=@p]
    [%subscribe project=@tas who=@p]
    [%unsubscribe project=@tas who=@p]
    [%send-subscription-update project=@tas]
    [%print-subscribers ~]
  ==
::+$  state-0  mymap=(map project=@tas (map note=@tas contents=@t))
+$  state-0  mymap=(map project=@tas [(map note=@tas contents=@t) (list member=@p)])
+$  project  [(map @tas @t) (list @p)]
+$  versioned-state
  $%  state-0
  ==
+$  card  card:agent:gall
--
