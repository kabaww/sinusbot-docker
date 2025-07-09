# SinusBot Docker Image

> [!IMPORTANT]
> This Docker Image is in no way affiliated with SinusBot, TeamSpeak, or Discord.

## Disclaimer

By using this image you accept the [Privacy statement of the TeamSpeak Systems GmbH](https://www.teamspeak.com/en/privacy-and-terms), the [SinusBot Privacy Policy](https://forum.sinusbot.com/help/privacy-policy/) and SinusBot license agreement.

> © 2013-2021 Michael Friese. All rights reserved. (https://www.sinusbot.com)
>
> This software is free for personal use only. If you want to use it commercially, please contact the author.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
>
> You may NOT redistribute this software or use this software commercially without prior written permission from the author.

*TeamSpeak 3 is © TeamSpeak Systems GmbH. This product and the author is in no way affiliated with TeamSpeak Systems GmbH.*

*Discord is © Hammer & Chisel Inc. This product and the author is in no way affiliated with Hammer & Chisel Inc.*

## Usage

### :whale: Docker Run

> [!NOTE]
> With the latest versions of sinusbot it is no longer possible to run as root. However, due to the initialization routine, the container itself needs to run as root.

By default the container will execute the binaries with the user and group ID `9987` - the same as used by the teamspeak docker container. If you wish to change these, you can pass any other valid uid/gid but 0 as environment variable to the container.

  ```bash
  docker run -d -p 8087:8087 \
             -v /opt/sinusbot/scripts:/opt/sinusbot/scripts \
             -v /opt/sinusbot/data:/opt/sinusbot/data \
             -e UID=1000 \
             -e GID=1000 \
             ghcr.io/gamer92000/sinusbot-docker:latest
  ```

### :whale: Docker Compose

A minimal docker compose might look like this:

```yaml
services:
  sinusbot:
    image: ghcr.io/gamer92000/sinusbot-docker:latest
    restart: unless-stopped
    environment:
      UID: 1000
      GID: 1000
    ports:
      - 8087:8087
    volumes:
      - ./scripts:/opt/sinusbot/scripts
      - ./data:/opt/sinusbot/data
```

Simply start the container with `docker compose up -d`.

A more complete example together with the TeamSpeak 6 server can be found [here](docker-compose.yml).

## Tags

- `latest` is the default tag
- for archival purposes, every release is also tagged with the commit hash of this repositories release commit, e.g. `4caa1ae`

You view the [full list of tags](https://github.com/Gamer92000/sinusbot-docker/pkgs/container/sinusbot-docker/versions?filters%5Bversion_type%5D=tagged) for specific versions.

## Get Password

After starting the SinusBot docker image the docker log will contain your credentials. Depending on how you started the container the method to access the logs will differ.

```txt
[...]
-------------------------------------------------------------------------------
Generating new bot instance with account 'admin' and password 'YOUR_PASSWORD_HERE'
PLEASE MAKE SURE TO CHANGE THE PASSWORD DIRECTLY AFTER YOUR FIRST LOGIN!!!
-------------------------------------------------------------------------------
[...]
```

## Override Password

By setting the `OVERRIDE_PASSWORD` environment variable you can override the password of the SinusBot. Example:

```bash
docker run -d -p 8087:8087 [...] -e OVERRIDE_PASSWORD=foobar sinusbot/docker
```

## Updating

Simply pull the latest version of the docker image and recreate the container according to your deployment method.

## Text-to-Speech

The Chromium Text-to-Speech engine is pre-installed but disabled by default due to higher cpu/memory usage.

To enable it you simply need to set the `TTS.Enabled` property to `true` in the `config.ini` stored in the `data` volume and restart your container.
Once it's enabled it can be used by setting the locale to `en-US` or `de-DE` in the instance settings.
