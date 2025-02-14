// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GasOptimization {
    // Packing variables into a single storage slot
    struct PackedData {
        uint64 a;
        uint64 b;
        uint64 c;
        uint64 d;
    }

    PackedData public packed;

    function setPackedData(uint64 _a, uint64 _b, uint64 _c, uint64 _d) public {
        packed = PackedData(_a, _b, _c, _d);
    }
}