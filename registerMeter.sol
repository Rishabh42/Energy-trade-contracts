pragma solidity >=0.4.22 <0.6.0;

contract registerMeter {
    mapping (address => bool) registeredMeter;
    address[] public registeredMeters;

    constructor() public payable{
        require(msg.value > 10000000000000000);
        registeredMeter[msg.sender] = true;
        registeredMeters.push(msg.sender);
    }
}
