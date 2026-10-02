// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RoyaltyNFT is ERC721, ERC2981, Ownable {
    uint256 public nextTokenId;

    constructor() ERC721("Royalty NFT", "RNFT") Ownable(msg.sender) {
        _setDefaultRoyalty(msg.sender, 500);
    }

    function mint(address to) external onlyOwner {
        _safeMint(to, nextTokenId);

        nextTokenId++;
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
