pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";
import "@zk-email/contracts/DKIMRegistry.sol";
import "../src/ProofOfTwitter.sol";
import "../src/Verifier.sol";

contract Deploy is Script, Test {
    function getPrivateKey() internal pure returns (uint256) {
        return xxxxxxxxxx;
    }

    function run() public {
        uint256 sk = getPrivateKey();
        address owner = vm.createWallet(sk).addr;
        vm.startBroadcast(sk);

        Verifier proofVerifier = new Verifier();
        console.log("Deployed Verifier at address: %s", address(proofVerifier));

        DKIMRegistry dkimRegistry = new DKIMRegistry(owner);
        console.log("Deployed DKIMRegistry at address: %s", address(dkimRegistry));

        // x.com hash for selector dkim-202308
        dkimRegistry.setDKIMPublicKeyHash(
            "x.com",
            bytes32(uint256(1983664618407009423875829639306275185491946247764487749439145140682408188330))
        );

        dkimRegistry.setDKIMPublicKeyHash(
            "x.com",
            bytes32(uint256(14900978865743571023141723682019198695580050511337677317524514528673897510335))
        );

        ProofOfTwitter testVerifier = new ProofOfTwitter(proofVerifier, dkimRegistry);
        console.log("Deployed ProofOfTwitter at address: %s", address(testVerifier));

        vm.stopBroadcast();
    }
}
