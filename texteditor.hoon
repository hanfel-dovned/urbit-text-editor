/-  *texteditor
/+  default-agent, dbug 
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  =(mark %texteditor-action)
  =/  act=texteditor-action  !<(texteditor-action vase)
  ?-  act
      [%create-project project=@tas]
    :-  ~
    ?.  =(our.bowl src.bowl)
      this
    %_    this
        state
      %.  [project.act [~ ~[our.bowl]]]
      %~  put  by  mymap
    ==
    ::
      [%delete-project project=@tas]
    :-  ~
    ?.  =(our.bowl src.bowl)
      this
    %_    this
        state
      %.  project.act
      %~  del  by  mymap
    ==
    ::
      [%create-note project=@tas note=@tas contents=@t]
    :-  ~
    ?~  =/(a +3:(~(got by mymap) project.act) (find ~[src.bowl] a))
      this
    ?.  (~(has by mymap) project.act)
      this
    %_    this
        state
      %-
        %~  put  by  mymap
        :+  project.act
        %.  [note.act contents.act]
        %~  put  by
        +2:(~(got by mymap) project.act)
        +3:(~(got by mymap) project.act)
    ==
    ::
      [%delete-note project=@tas note=@tas]
    :-  ~
    ?~  =/(a +3:(~(got by mymap) project.act) (find ~[src.bowl] a))
      this
    ?.  (~(has by mymap) project.act)
      this
    %_    this
        state
      %-
        %~  put  by  mymap
        :+  project.act
        %.  note.act
        %~  del  by
        +2:(~(got by mymap) project.act)
        +3:(~(got by mymap) project.act) 
    ==
    ::
      [%create-note-remote project=@tas note=@tas contents=@t who=@p]
    :_  this
    ?.  =(our.bowl src.bowl)
      ~
    :~  :*
      %pass
      /texteditor/(scot %p who.act)
      %agent
      [who.act %texteditor]
      %poke  %texteditor-action  !>([%create-note project.act note.act contents.act])
    ==  ==
    ::
      [%delete-note-remote project=@tas note=@tas who=@p]
    :_  this
    ?.  =(our.bowl src.bowl)
      ~
    :~  :*
      %pass
      /texteditor/(scot %p who.act)
      %agent
      [who.act %texteditor]
      %poke  %texteditor-action  !>([%delete-note project.act note.act])
    ==  ==
    ::
      [%give-permissions project=@tas who=@p]
    :-  ~
    ?.  =(our.bowl src.bowl)
      this
    ?.  (~(has by mymap) project.act)
      this
    %_    this
        state
      %-
        %~  put  by  mymap
        :+  project.act
        +2:(~(got by mymap) project.act)
        (snoc +3:(~(got by mymap) project.act) who.act)
    ==
    ::
      [%revoke-permissions project=@tas who=@p]
::    :-  [%give %kick /(scot %tas project.act) who.act]~ ::getting a type error here
    :-  ~
    ?.  =(our.bowl src.bowl)
      this
    ?:  =(who.act our.bowl)
      this
    ?.  (~(has by mymap) project.act)
      this
    %_    this
        state
      %-
        %~  put  by  mymap
        :+  project.act
        +2:(~(got by mymap) project.act)
        (skip +3:(~(got by mymap) project.act) |=(a=@ =(who.act a)))
    ==
    ::
      [%subscribe project=@tas who=@p] 
    :_  this
    ?.  =(our.bowl src.bowl)
      ~
    :~  :* 
      %pass
      /texteditor/(scot %p who.act)/(scot %tas project.act)
      %agent
      [who.act %texteditor]
      %watch  /(scot %tas project.act)
    ==  ==
    ::
      [%unsubscribe project=@tas who=@p] 
    :_  this
    ?.  =(our.bowl src.bowl)
      ~
    :~  :*
      %pass
      /texteditor/(scot %p who.act)/(scot %tas project.act)
      %agent
      [who.act %texteditor]
      %leave
      ~
    ==  ==
    ::
    ::Frontend will need to call send-subscription-update after running create-note, delete-note, or delete-project
    ::Which feels very inelegant
    ::
      [%send-subscription-update project=@tas]
    :-  [%give %fact ~[/(scot %tas project.act)] %texteditor-project !>((~(got by mymap) project.act))]~
    this
    ::
      [%print-subscribers ~]
    ~&  >  bowl  `this
    ::
  ==
++  on-arvo   on-arvo:def
++  on-init
  ^-  (quip card _this)
    `this(state (my ~[[%first-project [(my ~[[%first-file 'hello']]) ~[our.bowl]]]]))
++  on-save
  !>(state)
++  on-load 
  |=  old-state=vase
  ^-  (quip card _this)
  =/  prev  !<(versioned-state old-state)
    `this(state prev)
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  (~(has by mymap) +2:path) ::getting the tas from the path this way will only work if there's only one /
  ?~  =/(a +3:(~(got by mymap) +2:path) (find ~[src.bowl] a))
    :_  this  
    [%give %kick ~ ~]~
  :_  this
  [%give %fact ~ %texteditor-project !>((~(got by mymap) +2:path))]~
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this) 
::  ?+    wire  (on-agent:def wire sign)
::      [%counter @ ~]
    ?+  -.sign  (on-agent:def wire sign)
        %fact
      :-  ~
      %_    this
          state
        (~(put by mymap) +14:wire !<([(map @tas @t) (list @p)] q.cage.sign))
      ==  
    ==
++  on-fail   on-fail:def
--
