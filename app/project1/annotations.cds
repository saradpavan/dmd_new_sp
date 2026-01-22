using DatamigrationService as service from '../../srv/service';
annotate service.Waves with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'ID',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'startDate',
                Value : startDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'endDate',
                Value : endDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'actualStartDate',
                Value : actualStartDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'actualEndDate',
                Value : actualEndDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'StatusCriticality',
                Value : StatusCriticality,
            },
            {
                $Type : 'UI.DataField',
                Label : 'rag',
                Value : rag,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ragCriticality',
                Value : ragCriticality,
            },
            {
                $Type : 'UI.DataField',
                Label : 'completionPercent',
                Value : completionPercent,
            },
            {
                $Type : 'UI.DataField',
                Label : 'progressCriticality',
                Value : progressCriticality,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'ID',
            Value : ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'name',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'startDate',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'endDate',
            Value : endDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'actualStartDate',
            Value : actualStartDate,
        },
    ],
);

annotate service.Rollouts with @(
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'name',
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'status',
        },
    ]
);

annotate service.Mocks with @(
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'name',
        },
        {
            $Type : 'UI.DataField',
            Value : Status,
            Label : 'Status',
        },
    ]
);

annotate service.Mockstream with @(
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : mock_ID,
            Label : 'mock_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : mockStreamId,
            Label : 'mockStreamId',
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'status',
        },
    ],
    UI.LineItem #tableMacro1 : [
    ],
    UI.LineItem #tableMacro2 : [
        {
            $Type : 'UI.DataField',
            Value : stream.name,
            Label : 'name',
        },
        {
            $Type : 'UI.DataField',
            Value : stream.mockStreams.status,
            Label : 'status',
        },
    ],
);

annotate service.MockStreamObjects with @(
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : object.name,
            Label : 'name',
        },
    ],
    UI.LineItem #tableMacro1 : [
        {
            $Type : 'UI.DataField',
            Value : mockStreams_mockStreamId,
            Label : 'mockStreams_mockStreamId',
        },
        {
            $Type : 'UI.DataField',
            Value : object_id,
            Label : 'object_id',
        },
        {
            $Type : 'UI.DataField',
            Value : mockStreams.mockStreamId,
            Label : 'mockStreamId',
        },
        {
            $Type : 'UI.DataField',
            Value : object.name,
            Label : 'name',
        },
    ],
);

annotate service.Objects with @(
    UI.LineItem #tableMacro : [
        
    ]
);

