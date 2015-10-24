//@define Ext.calendar.data.EventMappings
/**
 * @class Ext.calendar.data.EventMappings
 * @extends Object
 * A simple object that provides the field definitions for Event records so that they can be easily overridden.
 */
Ext.ns('Ext.calendar.data');

Ext.calendar.data.EventMappings = {
    EventId: {
        name: 'Id',
        mapping: 'Id',
        type: 'string'
    },
    CalendarId: {
        name: 'CategoryId',
        mapping: 'CategoryId',
        type: 'string'
    },
    Title: {
        name: 'EventTitle',
        mapping: 'EventTitle',
        type: 'string'
    },
    StartDate: {
        name: 'StartDate',
        mapping: 'StartDate',
        convert: function (value) { if (value == "") return; if (value instanceof Date) return value; else return eval("new " + value.substr(1, value.length - 2)); }
    },
    EndDate: {
        name: 'EndDate',
        mapping: 'EndDate',
        convert: function (value) { if (value == "") return; if (value instanceof Date) return value; else return eval("new " + value.substr(1, value.length - 2)); }
    },
    Location: {
        name: 'Location',
        mapping: 'Location',
        type: 'string'
    },
    Notes: {
        name: 'Notes',
        mapping: 'Notes',
        type: 'string'
    },
    Url: {
        name: 'LinkUrl',
        mapping: 'LinkUrl',
        type: 'string'
    },
    IsAllDay: {
        name: 'IsAllDay',
        mapping: 'IsAllDay',
        type: 'boolean'
    },
    Reminder: {
        name: 'Reminder',
        mapping: 'Reminder',
        type: 'string'
    },
    TagId: {
        name: 'TagId',
        mapping: 'Id',
        type: 'string'
    },
    CreateUser: {
        name: 'CreateUser',
        mapping: 'CreateUser',
        type: 'string'
    },
    IsNew: {
        name: 'IsNew',
        mapping: 'n',
        type: 'boolean'
    }
};
