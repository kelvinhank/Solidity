//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract Lottery{   
    address owner;
    address payable[] players;
    uint loteryId;
    mapping (uint=>address) lotteryHistory;
    mapping(address=>bool) isEnterLottery;

    constructor(){
        owner=msg.sender;
    }
    modifier onlyOwner{
        require(msg.sender==owner,"not owner");
        _;
    }
    function getBalanceOfAddress(address user) public view returns(uint) {
        return user.balance;
    }
    function getBalanceOfContract() public view returns(uint){
        return address(this).balance;
    }
    function enterLottery() public payable{
        require(!isEnterLottery[msg.sender],"already enter lottery");
        require(msg.value==1 ether,"you need 1 ether to enter lottery");
        players.push(payable(msg.sender));
        isEnterLottery[msg.sender]=true;
    }
    function getRandomNumber() private view returns(uint){
        return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
    }
    function pickWinner() public payable onlyOwner{
        uint index = getRandomNumber()%players.length;
        players[index].transfer(address(this).balance);
        lotteryHistory[loteryId] = players[index];
        loteryId++;
       for(uint i=0;i<players.length;i++){
           isEnterLottery[players[i]]=false;
       }
    }
    function getWinnerByLotteryId(uint id) public view returns(address){
        return lotteryHistory[id];
    }


}