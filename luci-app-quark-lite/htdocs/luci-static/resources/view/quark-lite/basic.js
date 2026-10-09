'use strict';
'require view';
'require form';
'require uci';

return view.extend({
	load: function() {
		return uci.load('quark-lite');
	},

	render: function() {
		var m = new form.Map('quark-lite', _('夸克网盘'),
			_('轻量 OpenList，仅保留普通夸克网盘驱动。启用后通过端口 5244 完成首次设置并添加夸克存储。'));
		var s = m.section(form.TypedSection, 'quark_lite');
		s.anonymous = true;
		s.addremove = false;

		var o = s.option(form.Flag, 'enabled', _('启用'));
		o.rmempty = false;

		o = s.option(form.Value, 'data_dir', _('数据目录'));
		o.default = '/etc/openlist-quark-lite';
		o.rmempty = false;

		o = s.option(form.Value, 'delayed_start', _('延迟启动（秒）'));
		o.datatype = 'uinteger';
		o.default = '10';

		o = s.option(form.DummyValue, '_open', _('管理页面'));
		o.rawhtml = true;
		o.cfgvalue = function() {
			return '<a class="btn cbi-button-action" href="http://' + window.location.hostname + ':5244" target="_blank" rel="noreferrer">' + _('打开夸克网盘') + '</a>';
		};

		return m.render();
	}
});
