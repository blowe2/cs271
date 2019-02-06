// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

    @color
    M=0
    @8192
    D=A
    @count
    M=D //count=8191
    @i
    M=0 //i=0
    @SCREEN
    D=A
    @screen
    M=D //screen = screen address
    @current
    M=D //current = screen address
(CHANGESTATE)
    @i
    M=0 //i=0
    @current
    M=D //current = screen address
    @KBD
    D=M
    @color
    D=D+M
    @CHANGESTATE
    D;JEQ //if KBD input + color = 0, then jump to CHANGESTATE
    @KBD
    D=M
    @WHITE
    D;JEQ //if keyboard input is 0, then jump to WHITE
    @BLACK
    0;JMP //else jump to BLACK
(WHITE)
    @color
    M=0 //set color to 0
    @DRAW
    0;JMP //jump to draw
(BLACK)
    @color
    M=-1 //set color to -1
    @DRAW
    0;JMP //jump to draw
(DRAW)
    @i
    D=M
    @count
    D=D-M
    @CHANGESTATE
    D;JEQ //if i-8191=0, then jump to change screen
    @i
    D=M
    @screen
    D=D+M //D=screen + i
    @current
    M=D //current = screen + i
    @color
    D=M
    @current
    A=M //A = current
    M=D //RAM[current] = -1
    @i
    M=M+1 //i++
    @DRAW
    0;JMP




    