//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract Owned {
    address owner;
    
    constructor() public{
        owner = msg.sender;
        
    }
        
    modifier onlyOwner(){
        require(msg.sender == owner, "You are not allowed");
        _;
    }
    
}


contract InheritanceModifierExample is Owned{
   mapping (address => uint) public tokenBalance;
   
   uint tokenPrice = 1 ether;
   
   constructor() public{
       tokenBalance[owner] = 100;
   }
   
   
   function createNewToken() public onlyOwner {
       tokenBalance[owner]++;
   }
   
   function createNewToken_old() public{
       require(msg.sender == owner, "You are not allowed");
       tokenBalance[owner]++;
   }
   
   function burnToken() public onlyOwner{
       tokenBalance[owner]--; 
       
   }
   
   function purchaseToken() public payable{
       require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
       tokenBalance[owner] -= msg.value / tokenPrice;
       tokenBalance[msg.sender] += msg.value / tokenPrice;

       
   }
   
   function sendTokent(address _to, uint _amount) public {
       require(tokenBalance[msg.sender] >= _amount, "not enough tokens");
       assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
       assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
       
       
       
   }
    
}
