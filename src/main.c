#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/drivers/gpio.h>
#include <open62541/server.h>

#include <open62541/server.h>

int main(int argc, char** argv)
{
    /* Create a server listening on port 4840 (default) */
    UA_Server *server = UA_Server_new();

    /* Add a variable node to the server */

    /* 1) Define the variable attributes */
    UA_VariableAttributes attr = UA_VariableAttributes_default;
    attr.displayName = UA_LOCALIZEDTEXT("en-US", "the answer");
    UA_Int32 myInteger = 42;
    UA_Variant_setScalar(&attr.value, &myInteger, &UA_TYPES[UA_TYPES_INT32]);

    /* 2) Define where the node shall be added with which browsename */
    UA_NodeId newNodeId = UA_NODEID_STRING(1, "the.answer");
    UA_NodeId parentNodeId = UA_NS0ID(OBJECTSFOLDER);
    UA_NodeId parentReferenceNodeId = UA_NS0ID(ORGANIZES);
    UA_NodeId variableType = UA_NODEID_NULL; /* take the default variable type */
    UA_QualifiedName browseName = UA_QUALIFIEDNAME(1, "the answer");

    /* 3) Add the node */
    UA_Server_addVariableNode(server, newNodeId, parentNodeId,
                              parentReferenceNodeId, browseName,
                              variableType, attr, NULL, NULL);

    /* Run the server (until ctrl-c interrupt) */
    UA_StatusCode status = UA_Server_runUntilInterrupt(server);

    /* Clean up */
    UA_Server_delete(server);
    return status == UA_STATUSCODE_GOOD ? EXIT_SUCCESS : EXIT_FAILURE;
}
