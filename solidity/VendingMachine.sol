//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract VendingMachine{
    address public owner;
    mapping(address=>uint) public donutBalances;
    constructor(){
        owner = msg.sender;
        donutBalances[address(this)]=100;
    }
    function getVendingMachineBalance() public view returns(uint){
        return donutBalances[address(this)];
    }
    function restock(uint amount) public{
        require(msg.sender==owner,"not owner");
        donutBalances[address(this)]+=amount;
    }
    function purchase(uint amount) public payable{
        require(msg.value>=amount*1 ether,"you need 1 ether per donut");
        require(donutBalances[address(this)]>=amount,"not enough donut to purchase");
        donutBalances[address(this)]-=amount;
        donutBalances[msg.sender]+=amount;
    }
}