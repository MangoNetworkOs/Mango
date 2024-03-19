// tests modules cannot use transfer internal functions outside of the defining module

module a::m {
    use mgo::transfer::{Self, Receiving};
    use a::other;
    use mgo::object::UID;

    public fun t1(s: other::S) {
        transfer::transfer(s, @0x100);
    }

    public fun t2(s: other::S) {
        transfer::freeze_object(s);
    }

    public fun t3(s: other::S) {
        transfer::share_object(s);
    }

    public fun t4(p: &mut UID, s: Receiving<other::S>): other::S {
        transfer::receive(p, s)
    }

    public fun t5(s: &Receiving<other::S>) {
        transfer::receiving_object_id(s);
    }
}

module a::other {
    struct S has key {
        id: mgo::object::UID,
    }
}

module mgo::object {
    struct UID has store {
        id: address,
    }
    struct ID has copy, drop, store {
        id: address,
    }
}

module mgo::transfer {
    use mgo::object::{UID, ID};

    struct Receiving<phantom T: key> { }

    public fun transfer<T: key>(_: T, _: address) {
        abort 0
    }

    public fun public_transfer<T: key + store>(_: T, _: address) {
        abort 0
    }

    public fun freeze_object<T: key>(_: T) {
        abort 0
    }

    public fun public_freeze_object<T: key + store>(_: T) {
        abort 0
    }

    public fun share_object<T: key>(_: T) {
        abort 0
    }

    public fun public_share_object<T: key + store>(_: T) {
        abort 0
    }

    public fun receive<T: key>(_: &mut UID, _: Receiving<T>): T {
        abort 0
    }

    public fun public_receive<T: key + store>(_: &mut UID, _: Receiving<T>): T {
        abort 0
    }

    public fun receiving_object_id<T: key>(_: &Receiving<T>): ID {
        abort 0
    }
}
