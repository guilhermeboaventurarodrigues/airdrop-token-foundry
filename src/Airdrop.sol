import "./WorkToken.sol";

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Airdrop{

    //Enums
    enum Status {ACTIVE, PAUSED, CANCELLED} // ACTIVE = 0, PAUSED = 1, CANCELLED = 2 

    //Properties
    address private owner;
    address public tokenAddress; 
    address[] private subscribers;
    Status contractState;


    //Modifiers
    modifier isOwner(){
        require(msg.sender == owner, "Sender not owner");
        _;
    }

    //Events
    event NewWinner(address beneficiary, uint amount);

    //Constructor
    constructor(address token){
        owner = msg.sender;
        tokenAddress = token;
        contractState = Status.PAUSED;
    }

    //Public Functions
    function subscribe() public returns(bool){
        contractState = Status.ACTIVE;
        require(hasSubscribed(msg.sender));
        subscribers.push(msg.sender);
        return true;
    }

    function execute() public isOwner returns(bool){
        contractState = Status.ACTIVE;
        uint256 balance = WorkToken(tokenAddress).balanceOf(address(this));
        uint256 amountToTransfer = balance / subscribers.length;
        for(uint256 i=0; i<subscribers.length; i++){
            require(subscribers[i] != address(0));
            require(WorkToken(tokenAddress).transfer(subscribers[i], amountToTransfer));
            emit NewWinner(subscribers[i], amountToTransfer);
        }
        return true;
    }

    function state() public view returns(Status){
        return contractState;
    }

    function getSubscribers() public view returns(address[] memory){
        return subscribers;
    }

    //Private Functions
    function hasSubscribed(address subscribed) private view returns(bool){
        for(uint256 i=0; i<subscribers.length; i++){
          require(subscribed != subscribers[i], "JA INSCRITO");
        }
        return true;
    }

    //Kill
    function kill() public isOwner{
        contractState = Status.CANCELLED;
        selfdestruct(payable(owner));
    }
}