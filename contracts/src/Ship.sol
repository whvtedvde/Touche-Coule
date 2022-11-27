// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import './Main.sol';
import 'hardhat/console.sol';




abstract contract Ship {
  function update(uint x, uint y) public virtual;
  function fire() public virtual returns (uint, uint);
  function place(uint width, uint height) public virtual returns (uint, uint);
}

contract myShip is Ship
{


  //self postion
  uint my_postion_x;
  uint my_postion_y;
  //
  function update(uint x, uint y) public override virtual{
    
    }
  
  //declaration of arrays
  uint[] values_of_x;
  uint[] values_of_y;
  //
 
 //var for random
 uint randNonce = 0;
 //
 
  function fire() public override virtual returns (uint, uint){   
    // Initializing the state variable
    randNonce+=1;
    // Postisions to fire
    uint x;
    uint y;
    //sel
    uint sel;
    sel=(my_postion_x+my_postion_y)*my_postion_x+my_postion_y;
    // x = random between 0 and 49
    x=uint(keccak256(abi.encodePacked(block.timestamp+sel,msg.sender,randNonce))) % 50;
    randNonce+=1;
    // y = random between 0 and 49
    y=uint(keccak256(abi.encodePacked(block.timestamp+sel,msg.sender,randNonce))) % 50;
    //index for both the arrays values_of_x and values_of_y
    uint i=0;
    //loop to verify if the x and y arn't already in the arrays
    while(i < values_of_x.length)
      {  
      //if x and y are in the arrays re generate random
      while(x == values_of_x[i] && y == values_of_y[i]){
        randNonce+=1;
        // x = random between 0 and 49
        x=uint(keccak256(abi.encodePacked(block.timestamp+sel,msg.sender,randNonce))) % 50;
        randNonce+=1;
        // y = random between 0 and 49
        y=uint(keccak256(abi.encodePacked(block.timestamp+sel,msg.sender,randNonce))) % 50;
        //if ever a regeneration, make the index back to zero
        i=0; //so important
        }
        //moveing forward in the arrays
        i+=1;
      
      }
    
    //everytime if fires add them to arrays
    values_of_x.push(x);
    values_of_y.push(y);
    //print where it fires in the terminal
    console.log("-----------------------------------------------");
    for(i=0;i<values_of_x.length;i+=1)
    {
      console.log("%d %d\n",values_of_x[i],values_of_y[i]);
    }
    console.log("-----------------------------------------------");
    //
    
    //fire at x and y
    return(x,y);
    
    }
  
  
  
  function place(uint width, uint height) public override virtual returns (uint, uint){
    // Initializing the state variable
    randNonce+=1;
    // Postisions to place
    uint x;
    uint y;
    // x = random between 0 and 49
    x=uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % 50;
    randNonce+=1;
    // y = random between 0 and 49
    y=uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % 50;
    // init array with the position of the ship
    values_of_x.push(x);
    values_of_y.push(y);
    // store the position of the ship
    my_postion_x=x;
    my_postion_y=y;
    // return the values of x and y to the place function
    return(x,y);
    
    
    }

}


