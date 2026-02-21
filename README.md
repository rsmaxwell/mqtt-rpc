# mqtt-rpc

RPC-style request/response messaging over **MQTT v5**, alongside the usual publish/subscribe model.

Many apps need both:

- **Request/response** for operations that need a specific reply (e.g. login, “get page list”)
- **Pub/sub** for streaming events (e.g. live updates)

HTTP is excellent at request/response but often falls back to polling to stay up-to-date. MQTT is built for pub/sub, and MQTT v5 adds features that make request/response patterns practical.

This project provides a small framework for implementing **RPC semantics over MQTT v5**, using the MQTT v5 *Response Topic* and *Correlation Data* fields.

---

## Concepts

### Broker
MQTT requires a broker (server) such as **Mosquitto**. Your broker should be secured appropriately if exposed beyond a trusted network.

### Responder (server)
A Responder subscribes to a **well-known request topic**, processes incoming requests, and publishes responses to the **response topic** provided by the requester.

### Requestor (client)
A Requestor publishes requests to the request topic and waits for a response on its own response topic. Requestors can only call methods supported by the Responder.

---

## Repository layout

This repo uses Git submodules:

- `mqtt-rpc-common` — shared DTOs / utilities
- `mqtt-rpc-requestor` — client-side request code
- `mqtt-rpc-responder` — server-side responder code
- `scripts/` — CI-oriented scripts (prepare/deploy, build metadata, etc.)

---

## Getting the code

Clone with submodules:

```bash
git clone --recurse-submodules git@github.com:rsmaxwell/mqtt-rpc.git
