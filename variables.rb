TOP_LEFT = "\u250c"
HORIZONTAL = "\u2500"
TOP_RIGHT = "\u2510"
VERTICAL = "\u2502"
LOW_LEFT = "\u2514"
LOW_RIGHT = "\u2518"
space = ' '
$ball = {
    'empty' => "\u25ef",
    'white' => "\u2b24",
    'green' => "\u2b24".green,
    'purple' => "\u2b24".purple,
    'red' => "\u2b24".red,
    'yellow' => "\u2b24".yellow,
    'blue' => "\u2b24".blue
}
$numb_color = {
    # Make digits correspond to colors
    '1' => 'white',
    '2' => 'green',
    '3' => 'purple',
    '4' => 'red',
    '5' => 'yellow',
    '6' => 'blue'
}
$coin = {
    'empty' => "\u25cb",
    'white' => "\u25cf",
    'red' => "\e[31m\u25CF\e[0m" #"\u25cf".red
  }
$a_ball = {
    #playing balls
    'ball1' => $ball['empty'],
    'ball2' => $ball['empty'],
    'ball3' => $ball['empty'],
    'ball4' => $ball['empty'],
    #verification balls
    'v_ball1' => $coin['empty'],
    'v_ball2' => $coin['empty'],
    'v_ball3' => $coin['empty'],
    'v_ball4' => $coin['empty']
}
$ha = {
    #Coloured balls
    '1' => "\e[47m  1  \e[0m ",
    '2' => "\e[42m  2  \e[0m ",
    '3' => "\e[45m  3  \e[0m ",
    '4' => "\e[41m  4  \e[0m ",
    '5' => "\e[43m  5  \e[0m ",
    '6' => "\e[44m  6  \e[0m ",
  }