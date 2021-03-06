defmodule Bip32DerivationTest do
  use ExUnit.Case

  alias Aewallet.KeyPair, as: KeyPair

  test "bip32_vectors_1_aeternity" do
    seed = "000102030405060708090a0b0c0d0e0f" |> Base.decode16!(case: :mixed)
    master_key = KeyPair.generate_master_key(seed, :ae)

    ## Chain m
    assert "aeub7C9vNZ1egvxzQXZo3vTennMNQNsW8CW2dgjAHAz56ZkdY8GBsDbTMJ45vaUrZau5YjgnNeSUWJg8DFxYTnSmF3MEAYY4QfnYebhWVwgYX3Mq"
    = master_key |> KeyPair.to_public_key() |> KeyPair.format_key()
    assert "aepv7c8EuKLSHnNLxAPJQVuUh4fTxKLbB1hqx8HYN8QSEQqKxv7JVsoMXLo8WrLsHrujBmzXVeqqZZwGf8VA8QbSYSEKuLA6KAL3F5V6FHCPHo3z"
    = KeyPair.format_key(master_key)

    ## Chain m/0h
    assert "aeub7CCb5CfduEGu5KQP8mHMSSX2fwArKza77Xd5UQEuQzCz9BPzRwgJXfYUw7fqcJQ5Nje3MkyPmspjKAuMtVajKP84Rp8pRtgtvYhFdioBbukp"
    = master_key
    |> KeyPair.derive("M/0'") |> KeyPair.format_key()
    assert "aepv7cAubxzRW5gFcxDtVLjBLiq8DsdwNomvRyBTZMfGYqHgZyF74btChiHXXPU8BwZMxeuoTWryNnzGoydAxxtqDwDjkyxrdc1VCWiNeDUe66ED"
    = master_key |> KeyPair.derive("m/0'") |> KeyPair.format_key()

    ## Chain m/0h/1
    assert "aeub7CE4ACBNpqf6vLUN3xnKGuwe37VevcUXa1qYnxyufvHj6JjzDV9RHxAxECRABBVhThE8mCxuoerusDY1spXi6KbDSC2tmcWSPJFVr76Y2kdQ"
    = master_key
    |> KeyPair.derive("M/0'/1") |> KeyPair.format_key()
    assert "aepv7cCNgxWARh4TTyHsQYE9BCFjb3xjyRgLtTPvsvQGomNRX6b6r9MKTzuzpUHj2C2KDa72s4WrJ84W2M7PfQhmQwaZQHeq4vXfFNxKVUwWvttF"
    = master_key |> KeyPair.derive("m/0'/1") |> KeyPair.format_key()
  end

  test "bip32_vectors_2_aeternity" do
    seed = "fffcf9f6f3f0edeae7e4e1dedbd8d5d2cfccc9c6c3c0bdbab7b4b1aeaba8a5a29f9c999693908d8a8784817e7b7875726f6c696663605d5a5754514e4b484542"
    |> Base.decode16!(case: :mixed)
    master_key = KeyPair.generate_master_key(seed, :ae)

    ## Chain m/0/2147483647h/1
    assert "aeub7CHDFCHJN24dmbFmfUQzCvgvgufhqWGQDAPDLbko8PBwNobZhtJPq8LrXxWWkNoTpjnCNW12gucwWwBtJoU4mHfkGszbrQXX5x65VYyFVisf"
    = master_key
    |> KeyPair.derive("M/0/2147483647'/1")
    |> KeyPair.format_key()
    assert "aepv7cFXmxc5xsTzKE5H23rp7D12Er8ntKUDXbwbRZBAGEGdobSgLYWJ1B5u8ENKnX5dazH9rBy8gXq5DeBHMcT34u6rapZvYxzqVkgQKLyvcfzx"
    = master_key |> KeyPair.derive("m/0/2147483647'/1") |> KeyPair.format_key()

    ## Chain m/0/2147483647h/1/2147483646h
    assert "aeub7CJmwZmQ8FbCGVi6aVYxfJfaw3AfwYz8Xc3maGVVVuJUakA8mXCDbysjt79ffffDcKJLD4abX3tUTPhDVt5TB4wyFmwadkMuRxZe2ayJTFuq"
    = master_key
    |> KeyPair.derive("M/0/2147483647'/1/2147483646'")
    |> KeyPair.format_key()
    assert "aepv7cH6UL6Bj6zYp8Xbw4znZaygUydkzNBwr3c9fDurdkPB1Y1FQBQ7n2cnUP1LnH65GzMYmEWsr5nAp3eB5DjQTyR3jVRAuwdhuEK3WpY88F6y"
    = master_key |> KeyPair.derive("m/0/2147483647'/1/2147483646'") |> KeyPair.format_key()

    ## Chain m/0/2147483647h/1/2147483646h/2
    assert "aeub7CM4j8bcDzDMULSCTo7pPStd2EYpdcbKEUfcLtiqvui3eGMNiZ3mKJi8BANQJ9XW3wZHYQ2dL9uBfkgskLMmR4AnkDLNc7gtCAnZnN3mmB64"
    = master_key
    |> KeyPair.derive("M/0/2147483647'/1/2147483646'/2")
    |> KeyPair.format_key()
    assert "aepv7cKPFtvPpqci1yFhpNZeHjCiaB1ugRo8YvDzRr9D4knk54CVMDFfVMTAmSBg1AQqAyz9uGQTU1VsrrA9Bj5HYi2qnavfqKdh4NRiC1KQsht7"
    = master_key |> KeyPair.derive("m/0/2147483647'/1/2147483646'/2") |> KeyPair.format_key()
  end

  test "bip32_vectors_1_btc" do
    seed = "000102030405060708090a0b0c0d0e0f" |> Base.decode16!(case: :mixed)
    master_key = KeyPair.generate_master_key(seed, :btc)

    ## Chain m
    assert "xpub661MyMwAqRbcFtXgS5sYJABqqG9YLmC4Q1Rdap9gSE8NqtwybGhePY2gZ29ESFjqJoCu1Rupje8YtGqsefD265TMg7usUDFdp6W1EGMcet8"
    = master_key |> KeyPair.to_public_key() |> KeyPair.format_key()
    assert "xprv9s21ZrQH143K3QTDL4LXw2F7HEK3wJUD2nW2nRk4stbPy6cq3jPPqjiChkVvvNKmPGJxWUtg6LnF5kejMRNNU3TGtRBeJgk33yuGBxrMPHi"
    = KeyPair.format_key(master_key)

    ## Chain m/0h
    assert "xpub68Gmy5EdvgibQVfPdqkBBCHxA5htiqg55crXYuXoQRKfDBFA1WEjWgP6LHhwBZeNK1VTsfTFUHCdrfp1bgwQ9xv5ski8PX9rL2dZXvgGDnw"
    = master_key
    |> KeyPair.derive("M/0'") |> KeyPair.format_key()
    assert "xprv9uHRZZhk6KAJC1avXpDAp4MDc3sQKNxDiPvvkX8Br5ngLNv1TxvUxt4cV1rGL5hj6KCesnDYUhd7oWgT11eZG7XnxHrnYeSvkzY7d2bhkJ7"
    = master_key |> KeyPair.derive("m/0'") |> KeyPair.format_key()

    ## Chain m/0h/1
    assert "xpub6ASuArnXKPbfEwhqN6e3mwBcDTgzisQN1wXN9BJcM47sSikHjJf3UFHKkNAWbWMiGj7Wf5uMash7SyYq527Hqck2AxYysAA7xmALppuCkwQ"
    = master_key
    |> KeyPair.derive("M/0'/1") |> KeyPair.format_key()
    assert "xprv9wTYmMFdV23N2TdNG573QoEsfRrWKQgWeibmLntzniatZvR9BmLnvSxqu53Kw1UmYPxLgboyZQaXwTCg8MSY3H2EU4pWcQDnRnrVA1xe8fs"
    = master_key |> KeyPair.derive("m/0'/1") |> KeyPair.format_key()

    ## Chain m/0h/1/2h
    assert "xpub6D4BDPcP2GT577Vvch3R8wDkScZWzQzMMUm3PWbmWvVJrZwQY4VUNgqFJPMM3No2dFDFGTsxxpG5uJh7n7epu4trkrX7x7DogT5Uv6fcLW5"
    = master_key
    |> KeyPair.derive("M/0'/1/2'") |> KeyPair.format_key()
    assert "xprv9z4pot5VBttmtdRTWfWQmoH1taj2axGVzFqSb8C9xaxKymcFzXBDptWmT7FwuEzG3ryjH4ktypQSAewRiNMjANTtpgP4mLTj34bhnZX7UiM"
    = master_key |> KeyPair.derive("m/0'/1/2'") |> KeyPair.format_key()

    ## Chain m/0h/1/2h/2
    assert "xpub6FHa3pjLCk84BayeJxFW2SP4XRrFd1JYnxeLeU8EqN3vDfZmbqBqaGJAyiLjTAwm6ZLRQUMv1ZACTj37sR62cfN7fe5JnJ7dh8zL4fiyLHV"
    = master_key
    |> KeyPair.derive("M/0'/1/2'/2") |> KeyPair.format_key()
    assert "xprvA2JDeKCSNNZky6uBCviVfJSKyQ1mDYahRjijr5idH2WwLsEd4Hsb2Tyh8RfQMuPh7f7RtyzTtdrbdqqsunu5Mm3wDvUAKRHSC34sJ7in334"
    = master_key |> KeyPair.derive("m/0'/1/2'/2") |> KeyPair.format_key()

    ## Chain m/0h/1/2h/2/1000000000
    assert "xpub6H1LXWLaKsWFhvm6RVpEL9P4KfRZSW7abD2ttkWP3SSQvnyA8FSVqNTEcYFgJS2UaFcxupHiYkro49S8yGasTvXEYBVPamhGW6cFJodrTHy"
    = master_key
    |> KeyPair.derive("M/0'/1/2'/2/1000000000")
     |> KeyPair.format_key()
     assert "xprvA41z7zogVVwxVSgdKUHDy1SKmdb533PjDz7J6N6mV6uS3ze1ai8FHa8kmHScGpWmj4WggLyQjgPie1rFSruoUihUZREPSL39UNdE3BBDu76"
     = master_key |> KeyPair.derive("m/0'/1/2'/2/1000000000") |> KeyPair.format_key()
  end

  test "bip32_vectors_2_btc" do
    seed = "fffcf9f6f3f0edeae7e4e1dedbd8d5d2cfccc9c6c3c0bdbab7b4b1aeaba8a5a29f9c999693908d8a8784817e7b7875726f6c696663605d5a5754514e4b484542"
    |> Base.decode16!(case: :mixed)
    master_key = KeyPair.generate_master_key(seed, :btc)

    ## Chain m
    assert "xpub661MyMwAqRbcFW31YEwpkMuc5THy2PSt5bDMsktWQcFF8syAmRUapSCGu8ED9W6oDMSgv6Zz8idoc4a6mr8BDzTJY47LJhkJ8UB7WEGuduB"
    = master_key |> KeyPair.to_public_key() |> KeyPair.format_key()
    assert "xprv9s21ZrQH143K31xYSDQpPDxsXRTUcvj2iNHm5NUtrGiGG5e2DtALGdso3pGz6ssrdK4PFmM8NSpSBHNqPqm55Qn3LqFtT2emdEXVYsCzC2U"
    = KeyPair.format_key(master_key)

    ## Chain m/0
    assert "xpub69H7F5d8KSRgmmdJg2KhpAK8SR3DjMwAdkxj3ZuxV27CprR9LgpeyGmXUbC6wb7ERfvrnKZjXoUmmDznezpbZb7ap6r1D3tgFxHmwMkQTPH"
    = master_key
    |> KeyPair.derive("M/0")
    |> KeyPair.format_key()
    assert "xprv9vHkqa6EV4sPZHYqZznhT2NPtPCjKuDKGY38FBWLvgaDx45zo9WQRUT3dKYnjwih2yJD9mkrocEZXo1ex8G81dwSM1fwqWpWkeS3v86pgKt"
    = master_key |> KeyPair.derive("m/0") |> KeyPair.format_key()

    ## Chain m/0/2147483647h
    assert "xpub6ASAVgeehLbnwdqV6UKMHVzgqAG8Gr6riv3Fxxpj8ksbH9ebxaEyBLZ85ySDhKiLDBrQSARLq1uNRts8RuJiHjaDMBU4Zn9h8LZNnBC5y4a"
    = master_key
    |> KeyPair.derive("M/0/2147483647'")
    |> KeyPair.format_key()
    assert "xprv9wSp6B7kry3Vj9m1zSnLvN3xH8RdsPP1Mh7fAaR7aRLcQMKTR2vidYEeEg2mUCTAwCd6vnxVrcjfy2kRgVsFawNzmjuHc2YmYRmagcEPdU9"
    = master_key |> KeyPair.derive("m/0/2147483647'") |> KeyPair.format_key()

    ## Chain m/0/2147483647h/1
    assert "xpub6DF8uhdarytz3FWdA8TvFSvvAh8dP3283MY7p2V4SeE2wyWmG5mg5EwVvmdMVCQcoNJxGoWaU9DCWh89LojfZ537wTfunKau47EL2dhHKon"
    = master_key
    |> KeyPair.derive("M/0/2147483647'/1")
    |> KeyPair.format_key()
    assert "xprv9zFnWC6h2cLgpmSA46vutJzBcfJ8yaJGg8cX1e5StJh45BBciYTRXSd25UEPVuesF9yog62tGAQtHjXajPPdbRCHuWS6T8XA2ECKADdw4Ef"
    = master_key |> KeyPair.derive("m/0/2147483647'/1") |> KeyPair.format_key()

    ## Chain m/0/2147483647h/1/2147483646h
    assert "xpub6ERApfZwUNrhLCkDtcHTcxd75RbzS1ed54G1LkBUHQVHQKqhMkhgbmJbZRkrgZw4koxb5JaHWkY4ALHY2grBGRjaDMzQLcgJvLJuZZvRcEL"
    = master_key
    |> KeyPair.derive("M/0/2147483647'/1/2147483646'")
    |> KeyPair.format_key()
    assert "xprvA1RpRA33e1JQ7ifknakTFpgNXPmW2YvmhqLQYMmrj4xJXXWYpDPS3xz7iAxn8L39njGVyuoseXzU6rcxFLJ8HFsTjSyQbLYnMpCqE2VbFWc"
    = master_key |> KeyPair.derive("m/0/2147483647'/1/2147483646'") |> KeyPair.format_key()

    ## Chain m/0/2147483647h/1/2147483646h/2
    assert "xpub6FnCn6nSzZAw5Tw7cgR9bi15UV96gLZhjDstkXXxvCLsUXBGXPdSnLFbdpq8p9HmGsApME5hQTZ3emM2rnY5agb9rXpVGyy3bdW6EEgAtqt"
    = master_key
    |> KeyPair.derive("M/0/2147483647'/1/2147483646'/2")
    |> KeyPair.format_key()
    assert "xprvA2nrNbFZABcdryreWet9Ea4LvTJcGsqrMzxHx98MMrotbir7yrKCEXw7nadnHM8Dq38EGfSh6dqA9QWTyefMLEcBYJUuekgW4BYPJcr9E7j"
    = master_key |> KeyPair.derive("m/0/2147483647'/1/2147483646'/2") |> KeyPair.format_key()
  end


  test "error derivation btc" do
    seed = "000102030405060708090a0b0c0d0e0f" |> Base.decode16!(case: :mixed)
    master_key = KeyPair.generate_master_key(seed, :btc)

    public_master_key =
      master_key
      |> KeyPair.derive("M/0'/1/2'")

    assert_raise(
      RuntimeError,
      "Cannot derive Public Hardened child",
      fn ->
        KeyPair.derive(public_master_key, "M/100'")
      end)
  end

  test "public_derivation" do
    seed = "000102030405060708090a0b0c0d0e0f" |> Base.decode16!(case: :mixed)
    master_key = KeyPair.generate_master_key(seed, :btc)
    public_master_key =
      master_key
      |> KeyPair.derive("M/0'/1/2'/2")
    public_child_key = public_master_key |> KeyPair.derive("M/1000000000")

    ## Chain m/0h/1/2h/2/1000000000
    assert "xpub6H1LXWLaKsWFhvm6RVpEL9P4KfRZSW7abD2ttkWP3SSQvnyA8FSVqNTEcYFgJS2UaFcxupHiYkro49S8yGasTvXEYBVPamhGW6cFJodrTHy"
    = KeyPair.format_key(public_child_key)
  end
end
