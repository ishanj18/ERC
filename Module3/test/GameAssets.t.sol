// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/GameAssets.sol";

contract GameAssetsTest is Test {
    GameAssets game;

    address alice = address(1);
    address bob = address(2);

    function setUp() public {
        game = new GameAssets();
    }

    function testBatchMint() public {
        uint256[] memory ids = new uint256[](2);
        uint256[] memory amounts = new uint256[](2);

        ids[0] = game.GOLD();
        ids[1] = game.SWORD();

        amounts[0] = 100;
        amounts[1] = 1;

        game.batchMint(alice, ids, amounts);

        assertEq(game.balanceOf(alice, game.GOLD()), 100);
        assertEq(game.balanceOf(alice, game.SWORD()), 1);
    }

    function testBatchTransfer() public {
        uint256[] memory ids = new uint256[](2);
        uint256[] memory amounts = new uint256[](2);

        ids[0] = game.GOLD();
        ids[1] = game.SWORD();

        amounts[0] = 100;
        amounts[1] = 1;

        game.batchMint(alice, ids, amounts);

        vm.prank(alice);

        game.safeBatchTransferFrom(alice, bob, ids, amounts, "");

        assertEq(game.balanceOf(bob, game.GOLD()), 100);
        assertEq(game.balanceOf(bob, game.SWORD()), 1);
    }

    function testSoulboundItem() public {
        assertTrue(game.isSoulbound(game.SOULBOUND()));
    }

    function testSupplyCap() public {
        game.mint(alice, game.SWORD(), 1);

        assertEq(game.totalSupply(game.SWORD()), 1);
    }
}
