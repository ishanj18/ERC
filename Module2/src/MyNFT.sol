// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MyNFT is ERC721, ERC2981, Ownable {
    using Strings for uint256;

    uint256 public nextTokenId = 1;
    uint256 public constant MAX_SUPPLY = 100;

    string private baseTokenURI;

    constructor(
        string memory _baseURI
    ) ERC721("MyNFT", "MNFT") Ownable(msg.sender) {
        baseTokenURI = _baseURI;
        _setDefaultRoyalty(msg.sender, 500);
    }

    function mint(address to) public onlyOwner {
        require(nextTokenId <= MAX_SUPPLY, "Max supply reached");

        _safeMint(to, nextTokenId);
        nextTokenId++;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");

        string memory svg = string(
            abi.encodePacked(
                '<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300">',
                '<rect width="100%" height="100%" fill="black"/>',
                '<text x="50%" y="50%" fill="white" text-anchor="middle">',
                "NFT #",
                tokenId.toString(),
                "</text></svg>"
            )
        );

        string memory imageURI = string(
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(bytes(svg))
            )
        );

        bytes memory metadata = abi.encodePacked(
            '{"name":"NFT #',
            tokenId.toString(),
            '","image":"',
            imageURI,
            '"}'
        );

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(metadata)
                )
            );
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
