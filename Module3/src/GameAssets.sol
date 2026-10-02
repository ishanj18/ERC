// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GameAssets is ERC1155, Ownable {
    uint256 public constant GOLD = 1;
    uint256 public constant SWORD = 2;
    uint256 public constant SOULBOUND = 3;

    mapping(uint256 => uint256) public totalSupply;
    mapping(uint256 => uint256) public maxSupply;

    constructor()
        ERC1155("https://game.example/api/{id}.json")
        Ownable(msg.sender)
    {
        maxSupply[GOLD] = 1_000_000;
        maxSupply[SWORD] = 1;
        maxSupply[SOULBOUND] = 100;
    }

    function mint(address to, uint256 id, uint256 amount) public onlyOwner {
        require(
            totalSupply[id] + amount <= maxSupply[id],
            "Supply cap exceeded"
        );

        totalSupply[id] += amount;

        _mint(to, id, amount, "");
    }

    function batchMint(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts
    ) public onlyOwner {
        require(ids.length == amounts.length, "Length mismatch");

        for (uint256 i = 0; i < ids.length; i++) {
            require(
                totalSupply[ids[i]] + amounts[i] <= maxSupply[ids[i]],
                "Supply cap exceeded"
            );

            totalSupply[ids[i]] += amounts[i];
        }

        _mintBatch(to, ids, amounts, "");
    }

    function isSoulbound(uint256 id) public pure returns (bool) {
        return id == SOULBOUND;
    }

    function _update(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values
    ) internal override {
        if (from != address(0)) {
            for (uint256 i = 0; i < ids.length; i++) {
                require(ids[i] != SOULBOUND, "Soulbound item");
            }
        }

        super._update(from, to, ids, values);
    }
}
