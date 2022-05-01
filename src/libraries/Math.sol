// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract Math {
    function min(uint256 a, uint256 b) public pure returns (uint256) {
        return a < b ? a : b;
    }

    // babulonian method
    function sqrt(uint256 a) public pure returns (uint256 b) {
        if (a > 3) {

            b = a;
            uint256 c = a/2 + 1;
            while (c < b) {
                b = c;
                c = (a/b + b)/2;
            }

        } else if (a != 0) {
            b = 1;
        }

    }
}