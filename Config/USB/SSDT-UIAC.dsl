DefinitionBlock ("", "SSDT", 2, "ACDT", "_UIAC", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")

        Name(RMCF, Package()
        {
            // EH02 (8086_1c2d)
            "EH02", Package()
            {
                "port-count", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "PR01", Package()
                      {
                          "name", Buffer() { "PR01" },
                          "UsbConnector", 255,
                          "port", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                      },
                },
            },
            // EH01 (8086_3a34)
            "HUB1", Package()
            {
                "port-count", Buffer() { 0x06, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "HP11", Package()
                      {
                          "name", Buffer() { "HP11" },
                          "portType", 0,
                          "port", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                      },
                      "HP12", Package()
                      {
                          "name", Buffer() { "HP12" },
                          "portType", 0,
                          "port", Buffer() { 0x02, 0x00, 0x00, 0x00 },
                      },
                      "HP13", Package()
                      {
                          "name", Buffer() { "HP13" },
                          "portType", 0,
                          "port", Buffer() { 0x03, 0x00, 0x00, 0x00 },
                      },
                      "HP14", Package()
                      {
                          "name", Buffer() { "HP14" },
                          "portType", 0,
                          "port", Buffer() { 0x04, 0x00, 0x00, 0x00 },
                      },
                      "HP15", Package()
                      {
                          "name", Buffer() { "HP15" },
                          "portType", 0,
                          "port", Buffer() { 0x05, 0x00, 0x00, 0x00 },
                      },
                      "HP16", Package()
                      {
                          "name", Buffer() { "HP16" },
                          "portType", 0,
                          "port", Buffer() { 0x06, 0x00, 0x00, 0x00 },
                      },
                },
            },
            // XHC1 (1b73_1100)
            "1b73_1100", Package()
            {
                "port-count", Buffer() { 0x06, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "HS02", Package()
                      {
                          "name", Buffer() { "HS02" },
                          "UsbConnector", 3,
                          "port", Buffer() { 0x02, 0x00, 0x00, 0x00 },
                      },
                      "HS06", Package()
                      {
                          "name", Buffer() { "HS06" },
                          "UsbConnector", 3,
                          "port", Buffer() { 0x06, 0x00, 0x00, 0x00 },
                      },
                },
            },
            // EH01 (8086_3a34)
            "EH01", Package()
            {
                "port-count", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "PR10", Package()
                      {
                          "name", Buffer() { "PR10" },
                          "UsbConnector", 255,
                          "port", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                      },
                },
            },
            // EH02 (8086_1c2d)
            "HUB2", Package()
            {
                "port-count", Buffer() { 0x05, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "HP21", Package()
                      {
                          "name", Buffer() { "HP21" },
                          "portType", 0,
                          "port", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                      },
                      "HP22", Package()
                      {
                          "name", Buffer() { "HP22" },
                          "portType", 0,
                          "port", Buffer() { 0x02, 0x00, 0x00, 0x00 },
                      },
                      "HP23", Package()
                      {
                          "name", Buffer() { "HP23" },
                          "portType", 0,
                          "port", Buffer() { 0x03, 0x00, 0x00, 0x00 },
                      },
                      "HP24", Package()
                      {
                          "name", Buffer() { "HP24" },
                          "portType", 0,
                          "port", Buffer() { 0x04, 0x00, 0x00, 0x00 },
                      },
                      "HP25", Package()
                      {
                          "name", Buffer() { "HP25" },
                          "portType", 0,
                          "port", Buffer() { 0x05, 0x00, 0x00, 0x00 },
                      },
                },
            },
        })
    }
}
