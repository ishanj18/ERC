// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyToken {
    string public name = "MyToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;

    uint256 public totalSupply;

    address public owner;
    address public treasury;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    uint256 public constant TAX_PERCENT = 1;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(uint256 initialSupply, address _treasury) {
        owner = msg.sender;
        treasury = _treasury;

        totalSupply = initialSupply * 10 ** decimals;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "Zero address");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");

        uint256 tax = (amount * TAX_PERCENT) / 100;
        uint256 amountAfterTax = amount - tax;

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amountAfterTax;
        balanceOf[treasury] += tax;

        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        require(to != address(0), "Zero address");
        require(balanceOf[from] >= amount, "Insufficient balance");
        require(allowance[from][msg.sender] >= amount, "Allowance exceeded");

        uint256 tax = (amount * TAX_PERCENT) / 100;
        uint256 amountAfterTax = amount - tax;

        allowance[from][msg.sender] -= amount;

        balanceOf[from] -= amount;
        balanceOf[to] += amountAfterTax;
        balanceOf[treasury] += tax;

        return true;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Zero address");

        totalSupply += amount;
        balanceOf[to] += amount;
    }
}
