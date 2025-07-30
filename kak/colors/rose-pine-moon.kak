evaluate-commands %sh{
    
base=rgb:232136
surface=rgb:2a273f
overlay=rgb:393552
inactive=rgb:59546d
subtle=rgb:817c9c
text=rgb:e0def4
love=rgb:eb6f92
gold=rgb:f6c177
rose=rgb:ea9a97
pine=rgb:3e8fb0
foam=rgb:9ccfd8
iris=rgb:c4a7e7
highlight=rgb:312f44
highlightInactive=rgb:2a283d
highlightOverlay=rgb:3f3c53

    
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
