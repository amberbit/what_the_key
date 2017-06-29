defmodule WhatTheKeyTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  doctest WhatTheKey

  @key "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAsa0V3dKrkm9RsIU4JW3DoCSXjw2mxPKDGqJ3GLb0wzLDbHQRNlueWiwcRWF7nUazkl0TvfBuQQSJB9fXc8tLczBYqmUyC+JDPoqi3V3N8KzVjX+PfFRSkenMpwm2rjU06E7dT+Yx4z3C7OAcXHQ85Xo6BkesMG4VpVXA1ynsOlFOVyjAc+1yVtYRtGDMfAVWKaQLGFpiXq32wOjBBfk+XAhFTcrojLi7cy5esa2vo0LWnnjgFXlmWj/maRDTaap0oYhroQoVRmyQoGgic83gyqr2mKcmFxN3PP/T6DJOw07ISdR9BZCnRUp4AKYPKSqFxLx1hbpoct+vZR8d0p4HbQ=="

  test "main/1 should output user's public key if correct username was given" do
    assert capture_io(fn -> WhatTheKey.main(["hubertlepicki"], SystemMock) end) ==
      @key <> "\n"
  end

  test "main/1 should output error message when something goes wrong" do
    assert capture_io(fn -> WhatTheKey.main(["hubertlepickioo"], SystemMock) end) ==
      "Key not found" <> "\n"
  end

  test "main/1 should output usage when user does not know how to use tool" do
    assert capture_io(fn -> WhatTheKey.main([], SystemMock) end) ==
      "Usage: ./what_the_key github_username" <> "\n"
  end
end
