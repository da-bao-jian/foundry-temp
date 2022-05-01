// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "ds-test/test.sol";
import "../src/HarrySwapV2Pair.sol";
import "solmate/tokens/ERC20.sol";

contract MockERC20 is ERC20 {

    constructor(string memory _name, string memory _symbol) public ERC20(_name, _symbol, 18) 
    {
    }

    function mint(uint256 _amount, address to) public {
        _mint(to, _amount);
    }


}

interface Vm {
    function expectRevert(bytes calldata) external;

    function prank(address) external;

    function load(address c, bytes32 loc) external returns (bytes32);

    function warp(uint256) external;
}


contract HarrySwapV2PairTest is DSTest {

    Vm vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    MockERC20 token0;
    MockERC20 token1;
    HarrySwapV2Pair pair;

    function setUp() public {
        token0 = new MockERC20("HarryToken0", "HT0");
        token1 = new MockERC20("HarryToken1", "HT1");
        pair = new HarrySwapV2Pair(address(token0), address(token1));

        token0.mint(10 ether, address(this));
        token1.mint(10 ether, address(this));
    }

    function testMintLiqBootstraping() public {
        token0.transfer(address(pair), 1 ether);
        token1.transfer(address(pair), 1 ether);

        pair.mint();

        assertEq(pair.balanceOf(address(this)), 1 ether - 1000);
        assertEq(pair.totalSupply(), 1 ether);
    }
}