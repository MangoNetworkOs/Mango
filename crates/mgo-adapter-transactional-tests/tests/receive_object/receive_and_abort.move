// Copyright (c) MangoNet Labs Ltd.
// SPDX-License-Identifier: Apache-2.0

//# init --addresses tto=0x0

//# publish
module tto::M1 {
    use mgo::object::{Self, UID};
    use mgo::tx_context::{Self, TxContext};
    use mgo::transfer::{Self, Receiving};

    struct A has key, store {
        id: UID,
    }

    struct B has key, store {
        id: UID,
    }

    public fun start(ctx: &mut TxContext) {
        let a = A { id: object::new(ctx) };
        let a_address = object::id_address(&a);
        let b = B { id: object::new(ctx) };
        transfer::public_transfer(a, tx_context::sender(ctx));
        transfer::public_transfer(b, a_address);
    }

    public entry fun receiver(parent: &mut A, x: Receiving<B>) {
        let _b = transfer::receive(&mut parent.id, x);
        abort 0
    }
}

//# run tto::M1::start

//# view-object 2,0

//# view-object 2,1

// object(2,0)  should get bumped, but receiving(2,1) should not
//# run tto::M1::receiver --args object(2,0) receiving(2,1)

//# view-object 2,0

//# view-object 2,1
