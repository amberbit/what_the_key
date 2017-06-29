defmodule HTTPoisonMock do
  def get!("https://api.github.com/users/hubertlepicki/keys") do
    body = ~S"""
    [
      {
        "id": 13398117,
        "key": "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAsa0V3dKrkm9RsIU4JW3DoCSXjw2mxPKDGqJ3GLb0wzLDbHQRNlueWiwcRWF7nUazkl0TvfBuQQSJB9fXc8tLczBYqmUyC+JDPoqi3V3N8KzVjX+PfFRSkenMpwm2rjU06E7dT+Yx4z3C7OAcXHQ85Xo6BkesMG4VpVXA1ynsOlFOVyjAc+1yVtYRtGDMfAVWKaQLGFpiXq32wOjBBfk+XAhFTcrojLi7cy5esa2vo0LWnnjgFXlmWj/maRDTaap0oYhroQoVRmyQoGgic83gyqr2mKcmFxN3PP/T6DJOw07ISdR9BZCnRUp4AKYPKSqFxLx1hbpoct+vZR8d0p4HbQ=="
      }
    ]
    """

    %HTTPoison.Response{status_code: 200, body: body}
  end

  def get!(_) do
    body = ~S"""
    {
      "message": "Not Found",
      "documentation_url": "https://developer.github.com/v3"
    }
    """

    %HTTPoison.Response{status_code: 404, body: body}
  end
end
