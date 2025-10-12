#!/usr/bin/env python3

import json
import subprocess
import time
import sys
import select


def get_spotify_info():
    try:
        status_result = subprocess.run(
            ['playerctl', '-p', 'spotify', 'status'],
            capture_output=True, text=True, timeout=1
        )

        if status_result.returncode != 0:
            return {"text": ""}

        status = status_result.stdout.strip()

        metadata_result = subprocess.run(
            ['playerctl', '-p', 'spotify', 'metadata',
                '--format', '{{artist}}|||{{title}}'],
            capture_output=True, text=True, timeout=1
        )

        if metadata_result.returncode == 0:
            parts = metadata_result.stdout.strip().split('|||')
            artist = parts[0] if len(parts) > 0 else ""
            title = parts[1] if len(parts) > 1 else ""

            if title:
                icon = "" if status == "Paused" else ""

                if artist:
                    text = f"{artist} - {title}"
                else:
                    text = title

                if len(text) > 35:
                    text = text[:32] + "..."

                return {
                    "text": f"{icon} {text}",
                    "class": status.lower(),
                    "tooltip": f"Spotify: {status}\n{artist}\n{title}"
                }

        return {"text": ""}

    except Exception as e:
        return {"text": ""}


def main():
    # Imprimir estado inicial
    result = get_spotify_info()
    print(json.dumps(result))
    sys.stdout.flush()

    # Escuchar cambios usando --follow
    try:
        process = subprocess.Popen(
            ['playerctl', '-p', 'spotify', 'metadata', '--follow'],
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            text=True
        )

        while True:
            # Esperar por cambios con timeout
            ready, _, _ = select.select([process.stdout], [], [], 0.1)
            if ready:
                line = process.stdout.readline()
                if not line:  # EOF
                    break

                # Solo imprimir si hay un cambio real
                new_result = get_spotify_info()
                if new_result != result:
                    result = new_result
                    print(json.dumps(result))
                    sys.stdout.flush()

    except Exception as e:
        pass


if __name__ == "__main__":
    main()
