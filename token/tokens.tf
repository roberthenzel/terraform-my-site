data "cloudflare_api_token_permission_groups" "all" {}

resource "cloudflare_api_token" "roberthenzel" {
  name = "${var.domain}"

  # include all zones
  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
      data.cloudflare_api_token_permission_groups.all.zone["Zone Settings Write"],
      data.cloudflare_api_token_permission_groups.all.zone["Zone Write"],
      data.cloudflare_api_token_permission_groups.all.zone["Cache Purge"],
      data.cloudflare_api_token_permission_groups.all.zone["Analytics Read"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.*" = "*"
    }
  }
  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Account Settings Read"]
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

