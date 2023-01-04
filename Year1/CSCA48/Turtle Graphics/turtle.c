/**
 * CSC A48 - Intro to Computer Science II, Summer 2020
 *
 * This is the program file where you will implement your solution for
 * assignment 1. Please make sure you read through this file carefully
 * and that you understand what is provided and what you need to complete.
 *
 * You will need to have read the handout carefully. Parts where you have to
 * implement functionality are clearly labeled TODO.
 *
 * Be sure to test your work thoroughly, our testing will be extensive and will
 * check that your solution is *correct*, not only that it provides
 * functionality.
 *
 * Developed by Mustafa Quraish for CSCA48
 * (c) Mustafa Quraish 2020
 */
#include "imgUtils.c"
// This lets the driver code override the image size if it needs to. Make sure
// you don't hard-code these values anywhere!
#ifndef SIZEX
  #define SIZEX 512
  #define SIZEY 512
#endif

/*---------------------------------------------------------------------------*/

/**
 * This struct contains one node of the linked list, which represents a single
 * command to the Turtle. It's field should include:
 *
 *  - cmd   : A char array of size 10 holding the command name
 *
 *  - val   : An integer that stores a parameter for the command (like forward,
 *            backward and colour).
 *
 *  - next  : A pointer to a struct of the same type, this is used for the
 *            linked list
 *
 * TODO: Complete this struct definition
 ****/

typedef struct cmdnode {
    char cmd[10];
    int val;
    struct cmdnode *next;
} CmdNode;

/*---------------------------------------------------------------------------*/

CmdNode *newCmdNode(char cmd[10], int val) {
  /**
   * This function allocates a new CmdNode struct and initializes it's values
   * based on the input paramaters given. The next pointer is always
   * initialized to NULL.
   *
   * If the 'cmd' parameter is not a correct command, then print
   * "Invalid command.\n" and return NULL.
   *
   * Note that we will always pass in a value here, even if the
   * command doesn't need one. In this case, we can just ignore
   * it. It saves us from having to make separate functions to
   * deal with this.
   *
   * TODO: Implement this function
   */
    //if the cmd matches the string, then it will have a node called new and it gets assigned a value given.
    if(strcmp(cmd, "penup") == 0 || strcmp(cmd, "pendown") == 0 || strcmp(cmd, "right") == 0 || strcmp( cmd, "left") == 0 || strcmp(cmd, "forward") == 0 || strcmp(cmd, "backward") == 0 || strcmp(cmd, "colour") == 0){
        CmdNode *new = (CmdNode *) calloc(1, sizeof(CmdNode));
        (new) -> val = val;
        strcpy(new -> cmd, cmd); //copy the command name to the new node makesit reach until null so we have a full new node list and retrun the 'new' node.
        (new) -> next = NULL;
        return new;
    }
    printf("Invalid command.\n"); //if it's not an accurate command name, return NULL
    return NULL;
}

/*---------------------------------------------------------------------------*/

void printCommandList(CmdNode *head) {
  /**
   * This function prints out each command in the linked list one after the
   * other. Each command MUST also have a line number printed before it, this
   * is what you will be using to modify / delete them. To do this, initialize
   * a counter and then increment it for each command.
   *
   * Depending on whether or not the command needs an additional value
   * (like forward, backward and colour), use one of the following statements
   * to print out the information for each node:
   *            [ The format is "linenumber: command value" ]
   *
   * printf("%3d: %s %d\n", ... );     [With a value]
   *
   * printf("%3d: %s\n", ... );        [Without a value]
   *
   * Obviously, you also need to pass in the correct parameters to the print
   * function yourself, this is just so you have the correct format.
   *
   * TODO: Implement this function
   */
    int line_count = 0;
    while(head != NULL){
        //command if or not has value
        //print out the command
        if((strcmp(head -> cmd, "penup") == 0) || (strcmp(head -> cmd, "pendown") == 0) || (strcmp(head -> cmd, "right") == 0) || (strcmp(head -> cmd, "left") == 0)){
            printf("%3d: %s\n", line_count, head -> cmd);// for the command name that doesn't need a value, below is the one that does
        }
        else{
            printf("%3d: %s %d\n", line_count, head -> cmd, head -> val); //if it has a vlaue, then print the line counter and commandvalue with the command name
        }
        line_count += 1;
        //make head = head -> next (itirarete through the lst)
        head = head -> next;
    }
    return;
}

/*---------------------------------------------------------------------------*/

void queryByCommand(CmdNode *head, char cmd[10]) {
  /**
   * This function looks for commands in the linked list that match the input
   * query. It prints them out in the same format as the printCommandList()
   * function.
   *
   * Make sure that the line number of the commands that match is the same as
   * the line number that would be printed by the printCommandList() function.
   *
   * --------------------------------------------------------------------------
   *
   * For instance, if your printCommandList function outputs
   *
   *    0: penup
   *    1: forward 200
   *    2: right
   *    3: forward 50
   *
   * Then, if this function is called with the same list and cmd = "forward",
   * then your output here should be
   *
   *    1: forward 200
   *    3: forward 50
   *
   * TODO: Implement this function
   */
    int line_count = 0; //line counter (ie a counter variable)
    while(head != NULL){ //this list goes through the list to see if their is the same command name
        if(((strcmp(head -> cmd, "penup") == 0) || (strcmp(head -> cmd, "pendown") == 0) || (strcmp(head -> cmd, "right") == 0) || (strcmp(head -> cmd, "left") == 0)) && (strcmp(head -> cmd, cmd) == 0)){
            printf("%3d: %s\n", line_count, head -> cmd);
        }
        else if(strcmp(head -> cmd, cmd) == 0){
            printf("%3d: %s %d\n", line_count, head -> cmd, head -> val);
        }
        line_count += 1;
        head = head -> next;
    }
    return;//void function
}

/*---------------------------------------------------------------------------*/

int countCommands(CmdNode *head) {
  /**
   * This function counts and returns the length of the linked list. It
   * requires list traversal.  //traversal:  iterating through the list
   *
   * TODO: Implement this function
   */
    int link_len = 1;
    if(head == NULL){
        return 0;
    }
    while(head -> next != NULL){ //while it is not null, we can go through the list
        head = head -> next; //keeps on going onto the next node and counter keeps on adding
        link_len ++;
    }
    return link_len; //retrun the counter variable
}

/*---------------------------------------------------------------------------*/

CmdNode *insertCommand(CmdNode *head, CmdNode *new_CmdNode) {
  /**
   * This function inserts the node new_CmdNode *at the tail* of the linked
   * list. (You are adding a command at the end).
   *
   * If head == NULL, then the linked list is still empty.
   *
   * It returns a pointer to the head of the linked list with the new node
   * added into it.
   *
   * TODO: Implement this function
   */
    CmdNode *start_list = head; //set a temp variable to hold head as it changes when impleemting the rest of the function
    if(head == NULL){ // the case where the link list is empty
        return new_CmdNode; //just return the node becasue you already have no list to add the node to
    }
    while(head -> next != NULL){ //runs through the link list until it reaches the end
        head = head -> next;
    }
    head -> next = new_CmdNode; //when it is reading the link list, we set a list of the next node to the new command becasue we reached the end and we add the                          //end node to the new node
    return start_list;
}

/*---------------------------------------------------------------------------*/

CmdNode *insertCommandBefore(CmdNode *head, CmdNode *new_CmdNode, int cmdNum) {
  /**
   * This function inserts a new node *before* a given Node in the linked list.
   *
   * 'cmdNum' is an integer that corresponds to the line number of a command
   * from the printCommandList() function. Your task is to insert new_CmdNode
   * *before* the corresponding node in the linked list.
   * --------------------------------------------------------------------------
   *
   * For instance, if your initial list was
   *
   *    0: penup
   *    1: forward 200
   *    2: right
   *    3: forward 50
   *
   * And you added "pendown" before cmdNum = 2, then you will have
   *
   *    0: penup
   *    1: forward 200
   *    2: pendown
   *    3: right
   *    4: forward 50
   *
   * --------------------------------------------------------------------------
   *
   * If there is no command with the given cmdNum (cmdNum >= list size),
   * then print "Invalid Command Number.\n" to the screen and *do not*
   * insert the new node.
   *
   * Returns a pointer to the head of the linked list with the new node added
   * into it.
   *
   * TODO: Implement this function
   */
    CmdNode *start_list = head;
    for(int i = 0; i < cmdNum - 1; i++){ //keeps track of the command number and goes through the list of command numbers
        if(head -> next == NULL){ //case of empty list
            printf("Invalid Command Number.\n");
            return start_list;
        }
        head = head -> next;
    }
    if(cmdNum == 0){ //if the command needed to be inserted is at the head of the list
        new_CmdNode -> next = head;
        return  new_CmdNode;
    }
    // new node -> next is liked to head -> next so the rest of the list is read
    new_CmdNode -> next = head -> next;
    // head -> next linked to new node so the inserted node is between the givens
    head -> next = new_CmdNode;
    return start_list;
}

/*---------------------------------------------------------------------------*/

void updateCommand(CmdNode *head, int cmdNum, char cmd[10], int val) {
  /**
   * This function updates a specific node in the linked list based on the
   * input parameters.
   *
   * 'cmdNum' is an integer that corresponds to the line number of a command
   * from the printCommandList() function. Your task is to update the 'cmd' and
   * 'val' fields of this node.
   *
   * If there is no command with the given cmdNum, then print
   * "Invalid Command Number.\n" to the screen, and if 'cmd' is not a correct
   * command, then print "Invalid command.\n". In both these cases, do *not*
   * modify the list.
   *
   * TODO: Implement this function
   */
    for(int i = 0; i < cmdNum; i++){ //goes over the link list
        head = head -> next;
        if(head == NULL){ //if the list is empty
            printf("Invalid Command Number.\n");
            return;
        }
    }
    if(strcmp(cmd, "penup") != 0 && strcmp(cmd, "pendown") != 0 && strcmp(cmd, "right") != 0 && strcmp( cmd, "left") != 0 && strcmp(cmd, "forward") != 0 && strcmp(cmd, "backward") != 0 && strcmp(cmd, "colour") != 0){
        printf("Invalid command.\n");
        return; //if the command is valid
    }
    strcpy(head -> cmd, cmd); //copy the command and value to the node based on command number and the value put
    head -> val = val;
    return;
}

/*---------------------------------------------------------------------------*/


CmdNode *deleteCommand(CmdNode *head, int cmdNum) {
  /**
   * This function deletes the node from the linked list that corresponds to
   * the line number cmdNum. If there is no command with the given cmdNum, then
   * the function does nothing.
   *
   * Returns a pointer to the head of the linked list (which may have changed
   * as a result of the deletion)
   *
   * TODO: Implement this function
   */
    CmdNode *start_list = head;
    if(head == NULL){ //empty list case
        return NULL;
    }
    else if(cmdNum == 0){ //case that it should delete the head of the node
        CmdNode *post_head = head -> next; //the head after the node you want to erase should be stored (as well as the rest of the list)
        free(head); // 'delete' the head of the node
        return post_head; //return the rest of the link list
    }
    for(int i = 0; i < cmdNum - 1; i++){ //loop to read over the list
        head = head -> next;
        if(head == NULL){ //no command number given case
            return start_list;
        }
    }
    if(head -> next == NULL){ //for the case of the list to read over it
        return start_list;
    }
    CmdNode *temp = head -> next; //set the next node of head to be stored because if we delete this we want this to be the new head and retain the
                                 //list after this one
    head -> next = head -> next -> next; //the next head is than linked to the next head next in the linked list
    free(temp);
    return start_list;
}

/*---------------------------------------------------------------------------*/


CmdNode *deleteCommandList(CmdNode *head) {
  /**
   * This function deletes the linked list of commands, releasing all the
   * memory allocated to the nodes in the linked list.
   *
   * Returns a NULL pointer so that the head of the list can be set to NULL
   * after deletion.
   *
   * TODO: Implement this function
   */
    while(head != NULL){ //if the head is not empty and doesn't start with the head itself go through the list
        CmdNode *temp = head; //head is saved in a temporary varibale becasue we want to make sure that the head isn;t lost when we gop to the next line that
                              //makes the head of the node move to the next
        head = head -> next; //the link goes to delete everything
        free(temp); //we set temp go becasue the head next will be deleted and then head will be the next head.
    }
    return NULL;
}

/*---------------------------------------------------------------------------*/

void run(Image *im, CmdNode *head, int *endX, int *endY) {
  /**
   * This function runs the list of commands to move the turtle around and draw
   * the image, and returns the final position of the turtle in the variables
   * endX and endY.
   *
   * --------------------------------------------------------------------------
   *
   * NOTE: In the image we work with, the top-left pixel is (0,0),
   *       - x increases as you go right, up till SIZEX-1
   *       - y increases as you go down, up till SIZEY-1
   *
   *                 (0,0)                 (SIZEX-1, 0)
   *                   x------------------------x
   *                   |                        |
   *                   |                        |
   *                   |                        |
   *                   |                        |
   *                   |          IMAGE         |
   *                   |                        |
   *                   |                        |
   *                   |                        |
   *                   |                        |
   *                   |                        |
   *                   x------------------------x
   *             (0, SIZEY-1)            (SIZEX-1, SIZEY-1)
   *
   * The image is in grayscale (black and white), so the colours are numbers
   * from [0-255] where 0 is black, 255 is white, and the values in between
   * are varying levels of gray.
   *
   * You need to understand how the (x,y) values are stored so you know how
   * they should be updated when you move (down means y increases, etc). You do
   * not need to use the 'im' variable for anything other than passing it into
   * the drawLine() function described below.
   *
   * --------------------------------------------------------------------------
   *
   * Here's the setup - There is a turtle (with a pen) that walks along the
   * image. When the pen is down (on the paper), it draws a line along the path
   * that it walks on. (If you want to play around with this, consider looking
   * at the `turtle` library in python!)
   *
   * The turtle initially starts at pixel (0, 0) [at the top left],
   * facing right (in the positive x direction). The pen starts off
   * as `down`, with the default colour being black (0).
   *
   * You need to go through the linked list and 'run' the commands to keep
   * track of the turtles position, and draw the appropriate lines. Here is
   * what each command should do:
   *
   *  - penup          : Put the pen up (stop drawing)
   *  - pendown        : Put the pen down (start / continue drawing)
   *  - colour <val>   : Draw lines in colour <val> from now on
   *  - forward <val>  : Move the turtle forward <val> steps (pixels)
   *                     in the direction it is facing.
   *  - backward <val> : Same as above, except move backwards
   *  - right          : Turn the turtle to the right by 90 degrees
   *  - left           : Turn the turtle to the left by 90 degrees
   *
   * NOTE: Make sure that you do *not* go outside the image. For this, set the
   * maximum and minimum values of x and y to be 0 and SIZEX-1 / SIZEY-1
   * respectively.
   *
   * For instance, if the turtle is at (0,0) facing right, and your command is
   * `forward 100000`, it will only go forward till (SIZEX-1, 0), and end
   * up at the rightmost pixel in that row.
   *
   * IMPORTANT: Once you are done with all the commands, make sure you save the
   * final (x,y) location of the turtle into the variables endX and endY.
   *
   * --------------------------------------------------------------------------
   *
   * We have already implemented a drawLine() function (in imgUtils.c) which
   * you should use to actually draw the lines. It takes in the following:
   *
   *      - a pointer to an image struct (use 'im')
   *      - (x,y) location of start point
   *      - (x,y) location of end point
   *      - a colour to draw the line in [0-255]
   *
   * Note that this function only draws horizontal and vertical lines, so
   * either the x values or the y values of both points must be the same.
   * Both these points *must* also be within the image.
   *          [ 0 <= x < SIZEX,  0 <= y < SIZEY ]
   *
   *
   * TODO: Implement this function
   */
    int x_axis = 0;
    int y_axis = 0;
    int colour_track = 0;
    int pen = 0; // 1 is pen up and 0 is pendown
    int facing = 0; // 0 is facing right, 1 is facing down, 2 is facing left and 3 is facing up
    while(head != NULL){
        if (strcmp(head -> cmd, "penup") == 0 ){
            pen = 1;
        }
        else if(strcmp(head -> cmd, "pendown") == 0){
            pen = 0;
        }
        else if (strcmp(head -> cmd, "right") == 0){
            facing += 1;
            if(facing > 3){
                facing = 0;
            }
        }
        else if (strcmp(head -> cmd, "left") == 0){
            facing -= 1;
            if(facing < 0){
                facing = 3;
            }
        }
        else if (strcmp(head -> cmd, "forward") == 0){
            if(facing == 0){
                if(x_axis + head -> val < SIZEX){ //if it is at the end of the screen then it shouldn't move forward
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis + head -> val, y_axis, colour_track);
                        //turtle moves forward head -> val times
                    }
                    x_axis += head -> val; // if the turtle is facing right, then it should move along the x axis, not the y axis
                }
                else{
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, SIZEX - 1, y_axis, colour_track); //draw to the end of the screen (ie SIZEX - 1)
                    }
                    x_axis += SIZEX - 1;
                }
            }
            if(facing == 1){
                if(y_axis + head -> val < SIZEY){ //if it is at the end of the screen then it shouldn't move forward
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis, y_axis + head -> val, colour_track);
                    }
                    //turtle moves forward head -> val times
                    y_axis += head -> val;
                }
                else{
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis, SIZEY - 1, colour_track);
                    }
                    y_axis += SIZEY - 1;
                }
            }
            if(facing == 2){
                if(x_axis - head -> val > 0){ //if it is at the end of the screen then it shouldn't move forward
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis - head -> val, y_axis, colour_track);
                    }
                    //turtle moves forward head -> val times
                    x_axis -= head -> val;
                }
                else{
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, 0, y_axis, colour_track);
                    }
                    x_axis = 0;
                }
            }
            if(facing == 3){
                if(y_axis - head -> val > 0){ //if it is at the end of the screen then it shouldn't move forward
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis, y_axis - head -> val, colour_track);
                    }
                    //turtle moves forward head -> val times
                    y_axis -= head -> val;
                }
                else{
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis, 0, colour_track);
                    }
                    y_axis = 0;
                }
            }
        }
        else if(strcmp(head -> cmd, "backward") == 0){
            if(facing == 2){
                if(x_axis + head -> val < SIZEX){ //if it is at the end of the screen then it shouldn't move forward
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis + head -> val, y_axis, colour_track);
                        //turtle moves forward head -> val times
                    }
                    x_axis += head -> val; // if the turtle is facing right, then it should move along the x axis, not the y axis
                }
                else{
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, SIZEX - 1, y_axis, colour_track); //draw to the end of the screen (ie SIZEX - 1)
                    }
                    x_axis += SIZEX - 1;
                }
            }
            if(facing == 3){
                if(y_axis + head -> val < SIZEY){ //if it is at the end of the screen then it shouldn't move forward
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis, y_axis + head -> val, colour_track);
                    }
                    //turtle moves forward head -> val times
                    y_axis += head -> val;
                }
                else{
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis, SIZEY - 1, colour_track);
                    }
                    y_axis += SIZEY - 1;
                }
            }
            if(facing == 0){
                if(x_axis - head -> val > 0){ //if it is at the end of the screen then it shouldn't move forward
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis - head -> val, y_axis, colour_track);
                    }
                    //turtle moves forward head -> val times
                    x_axis -= head -> val;
                }
                else{
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, 0, y_axis, colour_track);
                    }
                    x_axis = 0;
                }
            }
            if(facing == 1){
                if(y_axis - head -> val > 0){ //if it is at the end of the screen then it shouldn't move forward
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis, y_axis - head -> val, colour_track);
                    }
                    //turtle moves forward head -> val times
                    y_axis -= head -> val;
                }
                else{
                    if(pen == 0){
                        drawLine(im, x_axis, y_axis, x_axis, 0, colour_track);
                    }
                    y_axis = 0;
                }
            }
        }
        else if (strcmp(head -> cmd, "colour") == 0){
            colour_track = head -> val;
        }
        head = head -> next;
    }
    *endX = x_axis;
    *endY = y_axis;
    return;
}

/*---------------------------------------------------------------------------*/
// All done!
