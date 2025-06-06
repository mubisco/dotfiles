local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[                             .     @$* @$3                                  ]],
  [[                            '$Nueeed$$ed$$eeec$$                            ]],
  [[         ,            4$Lze@*$C2$b* ed(he*rb$CC$*$bc@$r                     ]],
  [[   /@ |~~            .e$$"W$$B$B$**  ^$  e""##d?$Bd$$$Nc. ..      @\/~\     ]],
  [[   \==|         4$kd*Cr$6F#"`  **   .*==      # '"**F#$I$b$*       |   I    ]],
  [[      |         d$5N@$$"   ....eu$$$$$$N$*$zbeuu     #$d$$$$b.     / @/     ]],
  [[     @/     . z$Ted*"$P zue$*9d$$$@#       W$e@B$$L.    "#@$E$b@N           ]],
  [[           #d$Id*P#  'Nd$$B$**"       .*,     "#*N$$b$c   $$$*$$c           ]],
  [[          .d#+C6J   @@$B$*"          -***-        "#$$$$c   *$$$#$u         ]],
  [[       ..u$l4@"^"zJ$7W*"              '*`            ^*$@$$$r "$$E$@B>      ]],
  [[       *@$l$P"+Rd$$N#"          *     /|\     *        '"$$$c.. ?E$*b       ]],
  [[       z$ "*.  .Jz$"           ***   / | \   ***         '*@N$b   d**N      ]],
  [[     .z$JBR^bs@$$#          *   *   /  |  \   *  *         "$l*9N "bN$Nee   ]],
  [[    4$$.C*   dB@"          ***    _/  /^\  \_   ***         '$$$z> 3$b$$#   ]],
  [[     $"$e$  @*$"        *   *     \\^|   |^//    *   *        $$$u.^*$N$c   ]],
  [[    JPd$%  @@d"        ***        ***********       ***       '$Ni$  $EP$   ]],
  [[  :e$"*$  :et$          *         ***********        *         ^$$E  4$N$be ]],
  [[  ')$ud"  @6$                                                   9$$   $*@$" ]],
  [[   @F*$   *4P                       ./                          '$m#   .$$. ]],
  [[u*""""""""""""h                     ##=====                    e#""""""""""#]],
  [[E +e       ue. N                 ___##_______                 4F e=c     z*c]],
  [[#e$@e.. ..z6+6d"                #*************/               ^*cBe$u.  .$$@]],
  [[   $ ^"""" 4F"  ze=eu              ********              z***hc ^"$ ""*"" $ ]],
  [[   $       ^F :*    3r                                  @"  e "b  $       $ ]],
  [[ .e$        N $  'be$L...                            ...?be@F  $F $       9F]],
  [[4" $        $ $.  zm$*****h.                      ue""""*h6   J$" $       4%]],
  [[$  $        $ $$u5e" .     "k                    d"       #$bu$F  $       4F]],
  [["N $        $ ^d%P  dF      $  .            .e   $     -c  "N$F  .$       4F]],
  [[ #$$        $  $4*. "N.    zP  3r ..    ..  $c   *u     $  u$K$  4F       4L]],
  [[  ^N$e.     3  F$k*. "*C$$$# .z$" '$    4L  "$c. '#$eeedF  $$$9r JF       J$]],
  [[   $'"$$eu. 4  F3"K$ .e=*CB$$$$L .e$    '$bc.u$***hd6C""  4kF$4F $F     u@$F]],
  [[   $   '"*$*@u N'L$B*"z*""     "$F" 4k 4c '7$"      "*$eu 4'L$J" $   .e$*"4F]],
  [[   $      '"hC*$ "$#.P"          $me$"  #$*$       .  ^*INJL$"$  $e$$*#   4F]],
  [[   $         $b"h ".F     $"     ^F        $       9r   #L#$FJEd#C@"      4L]],
  [[  .$         $Jb   J"..  4b      uF        *k      J%    #c^ $" d$        4L]],
  [[ :"$         $k9   $ $%4c $Bme.ze$         '*$+eee@*$"  :r$    @L$        4$]],
  [[ $ $         $$Jr  $d" '$r "*==*"            "#**"" $r  4$3r  db$F        4F]],
  [[ $c$         $'*F  $"   '$            /\            $    *(L  $$$F         k]],
  [[ #i*e.       $ 4>  $  ue $         \`.||.'/         'L c  $$ .L$d         .$]],
  [[  "b."*e.    4 4   $  $%db=eL     `.<\||/>.'      e*+$/$r  $ '$"$       .d$$]],
  [[   $^#+cC*mu 4r4   4r:6@F  $$    -----++-----    <$. "N?N  F  $ $    ud$$* $]],
  [[   $    "*eJ"@L4   4k*3Ic.*"         .'`.         #*5.J$$..F  $ $ ue#2*"   $]],
  [[   $       "N."@r  4Fd" '$r        /.'||`.\        4$ '"N*d"  9.$#Ce*"     $]],
  [[   $         "e^"  'd" uz$%           \/           '$czr"k#"  4Pu@"        $]]
}
dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", "󱎸  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
  -- NOTE: requires the fortune-mod package to work
  -- local handle = io.popen("fortune")
  -- local fortune = handle:read("*a")
  -- handle:close()
  -- return fortune
  return "XAN"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
