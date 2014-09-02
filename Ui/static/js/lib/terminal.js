/**
 * Created with JetBrains PhpStorm.
 * Description: 终端组件，初步仅显示log信息
 * User: zoujiawei
 * Date: 14-2-17
 * Time: 上午11:27
 * To change this template use File | Settings | File Templates.
 */

angular.module('m3d.terminal', [])
    .directive('terminal', function() {
        return {
            restrict: 'EA',
            replace: true,
            template:
                '<div class="terminal"> \
                    <div class="terminal-head"> \
                        <ul class="terminal-nav clearfix"></ul> \
                        <div class="terminal-ctrl">\
                            <span class="close ion-close" ng-click="closeAll()"></span> \
                        </div> \
                    </div> \
                    <div class="terminal-content"></div> \
                </div> '
        };
    })
    .directive('terminalWindow', function() {
        return {
            restrict: 'EA',
            replace: true,
            template:
                '<div> \
                    <li class="nav" ng-class="{active: active}" ng-click="select(this)">\
                        <div class="ellipsis" title="{{title}}">{{title}}</div>\
                        <span class="close ion-ios7-close-outline" ng-click="close(this.instance)"></span>\
                    </li> \
                    <div class="content" ng-class="{active: active}"></div>\
                </div>',
            link: function(scope, elem, attrs) {
            }
        };
    })
    .factory('terminalStack', ['$$stackedMap', '$document', '$compile', '$rootScope', function($$stackedMap, $document, $compile, $rootScope) {
        var openedTerminal = $$stackedMap.createNew(),
            containerDom = null,
            bodyDom = $document.find('body');

        function remove(instance) {
            var terminals = openedTerminal.get(),
                length = openedTerminal.length();
            for (var i = 0; i < length; i++) {
                if (terminals[i].key === instance) {
                    if (terminals[i].value.active && length > 1) {
                        var newIndex = i === length - 1 ? i - 1 : i + 1;
                        select(terminals[newIndex].value);
                    }
                    openedTerminal.removeByIndex(i);
                    break;
                }
            }
            if (!openedTerminal.length()) {
                containerDom.remove();
                containerDom = null;
            } else {
                instance.navDom.remove();
                instance.contentDom.remove();
            }
        }

        function removeAll() {
            containerDom.remove();
            containerDom = null;
            openedTerminal.removeAll();
        }

        function select(terminal) {
            angular.forEach(openedTerminal.get(), function(item) {
                item.value.active = item.key === terminal.instance;
            });
        }

        function add(terminal) {
            openedTerminal.add(terminal.instance, terminal);
            select(terminal);
        }

        return {
            open: function(instance, terminal) {
                var opt = terminal.options,
                    scope = $rootScope.$new();
                scope.title = opt.title;
                scope.select = select;
                scope.close = remove;
                scope.closeAll = removeAll;
                scope.instance = instance;
                add(scope);
                if (!containerDom) {
                    containerDom = angular.element('<div terminal resizable></div>');
                    containerDom = $compile(containerDom)(scope);
                    bodyDom.append(containerDom);
                }
                var terminalDom = angular.element('<div terminal-window></div>');
                terminalDom = $compile(terminalDom)(scope);
                instance.navDom = terminalDom.find('.nav');
                instance.contentDom = terminalDom.find('.content');
                containerDom.find('.terminal-nav').append(instance.navDom);
                containerDom.find('.terminal-content').append(instance.contentDom);
            },

            close: function(instance) {
                remove(instance);
            },

            write: function(instance, data) {
                var dom = instance.contentDom,
                    log = '<div class="' + data.type + '">' + data.info + '</div>',
                    self = this;
                dom.append(log);
                // 延迟滚动，要不会卡死
                if (!this.timer) {
                    this.timer = setTimeout(function() {
                        dom.scrollTop(dom[0].scrollHeight);
                        self.timer = null;
                    });
                }
            }
        }
    }])
    .provider('terminal', function() {
        return {
            options: {
                title: 'Output'
            },

            $get: ['terminalStack', '$rootScope', function(terminalStack, $rootScope) {
                var self = this;
                return {
                    open: function(options) {
                        options = angular.extend({}, self.options, options);
                        var instance = {
                            write: function(data) {
                                terminalStack.write(instance, data);
                            },
                            close: function() {
                                terminalStack.close(instance);
                            }
                        };

                        var scope = (options.scope || $rootScope).$new();
                        terminalStack.open(instance, {
                            scope: scope,
                            options: options
                        });

                        return instance;
                    }
                }
            }]
        }
    });