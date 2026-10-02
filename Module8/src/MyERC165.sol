// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/interfaces/IERC165.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";

contract MyERC165 is IERC165 {
    function supportsInterface(
        bytes4 interfaceId
    ) public pure override returns (bool) {
        return
            interfaceId == type(IERC165).interfaceId ||
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC2981).interfaceId;
    }

    function checkCompatibility(
        address contractAddress,
        bytes4 interfaceId
    ) public view returns (bool) {
        return IERC165(contractAddress).supportsInterface(interfaceId);
    }
}
