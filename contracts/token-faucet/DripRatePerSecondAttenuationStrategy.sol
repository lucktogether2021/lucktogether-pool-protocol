// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.7.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/SafeCast.sol";
import "../utils/ExtendedSafeCast.sol";


/// @notice The attenuation strategy for faucet 
contract DripRatePerSecondAttenuationStrategy {
    using SafeMath for uint256;
    using SafeCast for uint256;
    using ExtendedSafeCast for uint256;  
    
    //// @notice calculate dripRatePerSecond 
    function calculateDripRatePerSecond(uint256 dripRatePerSecond,uint256 cycleCount,uint256 attenuationCoefficient) external pure returns(uint256) {
        uint256 dripRatePerSecondDifference = attenuationCoefficient.mul(cycleCount);
        if(dripRatePerSecond >= dripRatePerSecondDifference){
          return dripRatePerSecond - dripRatePerSecondDifference;
        }
        return dripRatePerSecond;
    } 

    /// @notice returns the current time.  Allows for override in testing.
    /// @return The current time (block.timestamp)
    function _currentTime() internal virtual view returns (uint32) {
       return block.timestamp.toUint32();
  }
}