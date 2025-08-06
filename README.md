
## Installation:
- Install [Docker](https://docs.docker.com/desktop/setup/install/).

## Test dcc-help
1. Start the container (first build may take some time):

```bash
docker compose up -d --build
```

2. Open an interactive shell inside the container:

```bash
docker compose exec dcc-help-demo bash
# Check model has finished downloading
ollama ls
```

3. Compile and run some code:

```
$ cd examples
$ dcc null.c
$ ./a.out
Runtime error: assigning to a value via a NULL pointer
dcc explanation: You are using a pointer which is NULL
A common error is assigning to *p when p == NULL.
Execution stopped in main() in null.c at line 5:
...
Don't understand? Get AI-generated help by running: dcc-help
$ dcc-help
# Error Message
The computer is trying to do something it can't, because you're trying to use a memory location that doesn't exist.

# Potential Causes
You've declared a pointer `x` and set it to `NULL`, meaning it doesn't point to anything.  Then, you're trying to access the value at that memory location using `*x`, which is like trying to open a door that's locked.

# Hints/Guidance
The error message is telling you to check if `x` is pointing to a valid memory address.  Make sure you're assigning a valid memory address to `x` before you try to use it.  You might need to allocate memory using a function like `malloc()` if you want to store data in a specific location.
```
4. Disconnect and Shut down container:
```bash
(CTRL-D)
docker compose down
```

## DCC Help Gemma-3N Models
DCC Help's fine-tuned models (E4B and E2B variants) are available for download from [Hugging Face](https://huggingface.co/collections/Project-Carbon/dcc-help-gemma3n-models-6892ec859e05f65e4e748eeb).

The fine-tuning details are available on the [gemma3n-sft](https://github.com/LorenzoLeeSolano/dcc-help/tree/gemma3n-sft) branch.
