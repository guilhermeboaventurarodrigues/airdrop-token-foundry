// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WorkToken.sol";

contract WorkTokenTest is Test {
    WorkToken token;
    address alice = vm.addr(0x1);
    address clara = vm.addr(0x2);

    function setUp() public {
        token = new WorkToken(1000);
    }

    function testName() public{
        assertEq(token.name(), "WorkToken");
    }

    function testSymbol() public{
        assertEq(token.symbol(), "WTK");
    }

    function testDecimals() public{
        assertEq(token.decimals(), 18);
    }

    function testTotalSupply() public{
        assertEq(token.totalSupply(), 1000);
    }

    function testBalanceOf() public{
        assertEq(token.balanceOf(address(this)), 1000);
    }

    function testTransfer() public{
        assertTrue(token.transfer(alice, 500));
        assertEq(token.balanceOf(alice), 500);
        assertEq(token.balanceOf(address(this)), 500);
    }

    function testApprove() public{
        assertTrue(token.approve(alice, 500));
    }

    function testAllowance() public{
        assertTrue(token.approve(alice,500));
        assertEq(token.allowance(address(this), alice), 500);
    }

    function testTransferFrom() public{
        assertTrue(token.approve(alice, 500));
        assertEq(token.allowance(address(this), alice), 500);
        vm.prank(alice);
        assertTrue(token.transferFrom(address(this), clara, 500));
        assertEq(token.balanceOf(address(this)), 500);
        assertEq(token.balanceOf(clara), 500);
        assertEq(token.allowance(address(this), alice), 0);
    }

    function testIncreaseAllowance() public{
        assertTrue(token.approve(alice, 500));
        assertEq(token.allowance(address(this), alice),500);
        assertTrue(token.increaseAllowance(alice, 100));
        assertEq(token.allowance(address(this), alice),600);
    }

    function testDecreaseAllowance() public{
       assertTrue(token.approve(alice, 500));
        assertEq(token.allowance(address(this), alice), 500);
        assertTrue(token.decreaseAllowance(alice, 100));
        assertEq(token.allowance(address(this), alice),400);
    } 

    //Test FAIL
    function testFailTransferNotBallance() public{
        assertTrue(token.transfer(alice, 1001));
    }

    function testFailTransferFromNotBallance() public{
        assertTrue(token.approve(alice, 500));
        assertEq(token.allowance(address(this), alice), 500);
        vm.prank(alice);
        assertTrue(token.transferFrom(address(this), clara,600));
    }

    function testFailApproveNotBallance() public{
        assertTrue(token.approve(alice, 10001));
    }
}
