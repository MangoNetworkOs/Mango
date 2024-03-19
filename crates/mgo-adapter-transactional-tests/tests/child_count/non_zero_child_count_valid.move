// Copyright (c) MangoNet Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

// DEPRECATED child count no longer tracked
// tests valid transfers of an object that has children

//# init --addresses test=0x0 --accounts A B

//# publish

module test::m {
    use mgo::tx_context::{Self, TxContext};
    use mgo::dynamic_object_field as ofield;

    struct S has key, store {
        id: mgo::object::UID,
    }

    struct R has key, store {
        id: mgo::object::UID,
        s: S,
    }

    public entry fun mint(ctx: &mut TxContext) {
        let id = mgo::object::new(ctx);
        let child = S { id: mgo::object::new(ctx) };
        ofield::add(&mut id, 0, child);
        mgo::transfer::public_transfer(S { id }, tx_context::sender(ctx))
    }

    public entry fun mint_and_share(ctx: &mut TxContext) {
        let id = mgo::object::new(ctx);
        let child = S { id: mgo::object::new(ctx) };
        ofield::add(&mut id, 0, child);
        mgo::transfer::public_share_object(S { id })
    }

    public entry fun transfer(s: S, recipient: address) {
        mgo::transfer::public_transfer(s, recipient)
    }

}

//
// Test share object allows non-zero child count
//

//# run test::m::mint_and_share --sender A

//# view-object 2,1

//
// Test transfer allows non-zero child count
//

//# run test::m::mint --sender A

//# run test::m::transfer --sender A --args object(4,2) @B

//# view-object 4,2

//
// Test TransferObject allows non-zero child count
//

//# run test::m::mint --sender A

//# transfer-object 7,1 --sender A --recipient B

//# view-object 7,1
