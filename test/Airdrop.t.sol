// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WorkToken.sol";
import "../src/Airdrop.sol";

contract AirdropTest is Test{
    WorkToken token;
    Airdrop airdrop;
    address alice = vm.addr(0x1);
    address clara = vm.addr(0x2);

    function setUp() public{
        token = new WorkToken(1000);
        airdrop = new Airdrop(address(token));
    }

    function testSubscribe() public{
        assertTrue(airdrop.subscribe());
    }

    function testExecute() public{
        assertTrue(token.transfer(address(airdrop), 1000));
        assertEq(token.balanceOf(address(airdrop)), 1000);
        vm.prank(alice);
        assertTrue(airdrop.subscribe());
        vm.prank(clara);
        assertTrue(airdrop.subscribe());
        assertTrue(airdrop.execute());
        assertEq(token.balanceOf(alice), 500);
        assertEq(token.balanceOf(clara), 500);
    }

    //Test FAIL
    function testFailHasSubscribe() public{
        assertTrue(airdrop.subscribe());
        assertTrue(airdrop.subscribe());
    }

    function testFailExecuteNotOwner() public{
        assertTrue(token.transfer(address(airdrop), 1000));
        assertEq(token.balanceOf(address(airdrop)), 1000);
        vm.prank(alice);
        assertTrue(airdrop.subscribe());
        vm.prank(clara);
        assertTrue(airdrop.subscribe());
        vm.prank(clara);
        assertTrue(airdrop.execute());
    }
}