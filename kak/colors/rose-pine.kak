evaluate-commands %sh{
    
base=rgb:191724
surface=rgb:1f1d2e
overlay=rgb:26233a
inactive=rgb:555169
subtle=rgb:6e6a86
text=rgb:e0def4
love=rgb:eb6f92
gold=rgb:f6c177
rose=rgb:ebbcba
pine=rgb:31748f
foam=rgb:9ccfd8
iris=rgb:c4a7e7
highlight=rgb:2a2837
highlightInactive=rgb:211f2d
highlightOverlay=rgb:3a384a

    
## code
echo "
    face global value ${iris}
    face global type ${iris}
    face global identifier ${subtle}
    face global string ${gold}
    face global keyword ${pine}
    face global operator default
    face global attribute ${foam}
    face global comment ${subtle}+i
    face global meta ${foam}
    face global builtin ${pine}

    face global variable ${rose}
    face global module ${foam}
    face global function ${foam}
"

## markup
echo "
    face global title ${rose}+b
    face global header ${rose}
    face global bold default
    face global italic default
    face global mono ${rose}
    face global block ${pine}
    face global link ${love}
    face global bullet ${rose}
    face global list ${rose}
"

## builtin
echo "
    face global Default ${text},${base}
    face global PrimarySelection default,${highlight}
    face global SecondarySelection default,${highlightInactive}
    face global PrimaryCursor ${base},${text}
    face global SecondaryCursor default,${inactive}
    face global LineNumbers ${subtle},${base}
    face global LineNumberCursor ${gold},${base}
    face global MenuForeground ${text},${overlay}
    face global MenuBackground ${subtle},${surface}
    face global MenuInfo ${inactive}
    face global Information ${text},${overlay}
    face global Error ${base},${love}
    face global StatusLine ${text},${surface}
    face global StatusLineMode ${rose}
    face global StatusLineInfo ${foam}
    face global StatusLineValue ${pine}
    face global StatusCursor ${base},${text}
    face global Prompt ${foam},${surface}
    face global MatchingChar default+u
    face global BufferPadding ${inactive},${base}
    face global Whitespace ${inactive}+f
"

}
