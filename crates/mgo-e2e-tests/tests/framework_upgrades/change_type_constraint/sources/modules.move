// Copyright (c) MangoNet Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

module mgo_system::msim_extra_1 {
    use mgo::object::UID;
    use mgo::tx_context::TxContext;

    struct Type has drop {
        x: u64,
    }

    struct Obj has key {
        id: UID,
    }

    struct AlmostObj {
        id: UID,
    }

    public fun canary(): u64 {
        private_function(45)
    }

    entry fun mint(_ctx: &mut TxContext) {}

    entry fun entry_fun() {}

    fun private_function(x: u64): u64 {
        x + 1
    }

    fun private_function_2(x: u64): u64 { x }
    fun private_function_3(_x: u64) {}

    public fun generic<T: copy + drop + store>(_t: T) {}
}
