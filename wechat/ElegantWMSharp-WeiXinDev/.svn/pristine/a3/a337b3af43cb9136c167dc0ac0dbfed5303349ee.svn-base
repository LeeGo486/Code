/**
 * @class Ext.calendar.form.field.ReminderCombo
 * @extends Ext.form.ComboBox
 * <p>A custom combo used for choosing a reminder setting for an event.</p>
 * <p>This is pretty much a standard combo that is simply pre-configured for the options needed by the
 * calendar components. The default configs are as follows:<pre><code>
    width: 200,
    fieldLabel: 'Reminder',
    queryMode: 'local',
    triggerAction: 'all',
    forceSelection: true,
    displayField: 'desc',
    valueField: 'value'
</code></pre>
 * @constructor
 * @param {Object} config The config object
 */
Ext.define('Ext.calendar.form.field.ReminderCombo', {
    extend: 'Ext.form.field.ComboBox',
    alias: 'widget.reminderfield',

    fieldLabel: 'Reminder',
    queryMode: 'local',
    triggerAction: 'all',
    forceSelection: true,
    displayField: 'desc',
    valueField: 'value',

    // private
    initComponent: function() {
        this.store = this.store || new Ext.data.ArrayStore({
            fields: ['value', 'desc'],
            idIndex: 0,
            data: [
            ['', '不提醒'],
            ['0', '开始后提醒'],
            ['5', '开始前5分钟'],
            ['15', '开始前15分钟'],
            ['30', '开始前30分钟'],
            ['60', '开始前1小时'],
            ['90', '开始前1.5小时'],
            ['120', '开始前2小时'],
            ['180', '开始前3小时'],
            ['360', '开始前6小时'],
            ['720', '开始前12小时'],
            ['1440', '开始前1天'],
            ['2880', '开始前2天'],
            ['4320', '开始前3天'],
            ['5760', '开始前4天'],
            ['7200', '开始前5天'],
            ['10080', '开始前1周'],
            ['20160', '开始前2周']
            ]
        });

        this.callParent();
    },

    // inherited docs
    initValue: function() {
        if (this.value !== undefined) {
            this.setValue(this.value);
        }
        else {
            this.setValue('');
        }
        this.originalValue = this.getValue();
    }
});
