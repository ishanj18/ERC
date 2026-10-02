// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract My777Token {
    string public name = "My777Token";
    string public symbol = "M777";
    uint8 public decimals = 18;

    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    event Sent(address indexed from, address indexed to, uint256 amount);

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply;
        balanceOf[msg.sender] = initialSupply;
    }

    function send(address to, uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        emit Sent(msg.sender, to, amount);
    }
}
