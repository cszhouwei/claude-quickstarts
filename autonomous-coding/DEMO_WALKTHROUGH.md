# Autonomous Coding Agent - 完整运行演示

本文档展示 autonomous coding agent 的完整运行过程，包括实际输出、生成的文件和每个步骤的详细说明。

## 运行命令

```bash
# 设置 API Key
export ANTHROPIC_API_KEY='your-api-key-here'

# 运行快速测试（20个测试用例，2次迭代）
cd /home/user/claude-quickstarts/autonomous-coding
python3 autonomous_agent_demo.py \
    --project-dir ./test_todo_app \
    --max-iterations 2
```

---

## 第一次迭代：初始化会话（3-5分钟）

### 启动输出

```
======================================================================
  AUTONOMOUS CODING AGENT DEMO
======================================================================

Project directory: test_todo_app
Model: claude-sonnet-4-5-20250929
Max iterations: 2

Fresh start - will use initializer agent

======================================================================
  NOTE: First session takes 10-20+ minutes!
  The agent is generating 20 detailed test cases.
  This may appear to hang - it's working. Watch for [Tool: ...] output.
======================================================================

Created security settings at test_todo_app/.claude_settings.json
   - Sandbox enabled (OS-level bash isolation)
   - Filesystem restricted to: /home/user/claude-quickstarts/autonomous-coding/test_todo_app
   - Bash commands restricted to allowlist (see security.py)
   - MCP servers: puppeteer (browser automation)

======================================================================
  SESSION 1: INITIALIZER
======================================================================

Sending prompt to Claude Agent SDK...
```

### Agent 开始工作

```
[Tool: Read]
   Input: {'file_path': 'app_spec.txt'}
   [Done]

I've read the specification. This is a Simple Todo App with React frontend and Node.js backend.
Let me create the feature_list.json with 20 comprehensive test cases.

[Tool: Write]
   Input: {'file_path': 'feature_list.json', 'content': '[{\n  "category": "functional",\n  ...
   [Done]

I've created feature_list.json with 20 detailed test cases covering:
- Basic CRUD operations (8 tests)
- Filter functionality (3 tests)
- UI/UX features (5 tests)
- Edge cases (4 tests)

Now let me create the init.sh script...

[Tool: Write]
   Input: {'file_path': 'init.sh', 'content': '#!/bin/bash\n\n...'}
   [Done]

[Tool: Bash]
   Input: {'command': 'chmod +x init.sh'}
   [Done]

Now initializing git repository...

[Tool: Bash]
   Input: {'command': 'git init'}
   [Done]

[Tool: Write]
   Input: {'file_path': 'README.md', 'content': '# Simple Todo App\n\n...'}
   [Done]

[Tool: Bash]
   Input: {'command': 'git add . && git commit -m "Initial setup: feature_list.json, init.sh, and project structure"'}
   [Done]

Now creating the basic project structure...

[Tool: Bash]
   Input: {'command': 'mkdir -p src/components src/styles server'}
   [Done]

[Tool: Write]
   Input: {'file_path': 'package.json', 'content': '{\n  "name": "simple-todo-app",\n  ...'}
   [Done]

[Tool: Write]
   Input: {'file_path': 'server/package.json', 'content': '{\n  "name": "todo-server",\n  ...'}
   [Done]

I've completed the initialization. Let me start implementing the first feature...

[Tool: Write]
   Input: {'file_path': 'server/index.js', 'content': 'const express = require("express");\n...'}
   [Done]

[Tool: Write]
   Input: {'file_path': 'src/App.jsx', 'content': 'import React, { useState, useEffect } from "react";\n...'}
   [Done]

[Tool: Bash]
   Input: {'command': 'git add . && git commit -m "Add basic server and React app structure"'}
   [Done]

[Tool: Write]
   Input: {'file_path': 'claude-progress.txt', 'content': 'Session 1 - Initializer\n\nCompleted:\n...'}
   [Done]

----------------------------------------------------------------------
```

### 第一次迭代结束

```
Agent will auto-continue in 3s...

Progress: 0/20 tests passing (0.0%)

Preparing next session...
```

---

## 生成的文件结构（第一次迭代后）

```
test_todo_app/
├── .git/                          # Git 仓库
├── .claude_settings.json          # 安全配置
├── app_spec.txt                   # 项目规格（复制的）
├── feature_list.json              # 20个测试用例
├── init.sh                        # 初始化脚本
├── README.md                      # 项目文档
├── claude-progress.txt            # 进度笔记
├── package.json                   # 前端依赖
├── index.html                     # HTML 入口
├── vite.config.js                 # Vite 配置
├── src/
│   ├── App.jsx                    # React 主组件
│   ├── main.jsx                   # React 入口
│   └── components/
│       ├── TodoInput.jsx
│       ├── TodoList.jsx
│       └── TodoFilters.jsx
└── server/
    ├── package.json               # 后端依赖
    └── index.js                   # Express 服务器
```

### feature_list.json 内容示例

```json
[
  {
    "category": "functional",
    "description": "User can add a new todo item",
    "steps": [
      "Step 1: Navigate to http://localhost:5173",
      "Step 2: Type 'Buy groceries' in the input field",
      "Step 3: Click the 'Add' button",
      "Step 4: Verify the todo appears in the list",
      "Step 5: Verify the input field is cleared"
    ],
    "passes": false
  },
  {
    "category": "functional",
    "description": "User can mark a todo as completed",
    "steps": [
      "Step 1: Navigate to http://localhost:5173",
      "Step 2: Add a todo 'Test task'",
      "Step 3: Click the checkbox next to the todo",
      "Step 4: Verify the todo has strikethrough style",
      "Step 5: Verify completed count increases"
    ],
    "passes": false
  },
  {
    "category": "functional",
    "description": "User can delete a todo item",
    "steps": [
      "Step 1: Navigate to http://localhost:5173",
      "Step 2: Add a todo 'Delete me'",
      "Step 3: Click the delete button (X)",
      "Step 4: Verify the todo is removed from the list",
      "Step 5: Verify total count decreases"
    ],
    "passes": false
  },
  {
    "category": "functional",
    "description": "Filter shows only active todos",
    "steps": [
      "Step 1: Navigate to http://localhost:5173",
      "Step 2: Add todos 'Active task' and 'Done task'",
      "Step 3: Mark 'Done task' as completed",
      "Step 4: Click 'Active' filter button",
      "Step 5: Verify only 'Active task' is visible"
    ],
    "passes": false
  },
  {
    "category": "style",
    "description": "Todo list has clean, centered layout",
    "steps": [
      "Step 1: Navigate to http://localhost:5173",
      "Step 2: Take screenshot",
      "Step 3: Verify container is centered on page",
      "Step 4: Verify consistent spacing between elements",
      "Step 5: Verify readable font sizes"
    ],
    "passes": false
  },
  {
    "category": "functional",
    "description": "Completed todos display with strikethrough",
    "steps": [
      "Step 1: Navigate to http://localhost:5173",
      "Step 2: Add a todo",
      "Step 3: Mark it as completed",
      "Step 4: Take screenshot",
      "Step 5: Verify text has strikethrough decoration"
    ],
    "passes": false
  },
  {
    "category": "functional",
    "description": "Empty input cannot add todo",
    "steps": [
      "Step 1: Navigate to http://localhost:5173",
      "Step 2: Leave input field empty",
      "Step 3: Click 'Add' button",
      "Step 4: Verify no todo is added",
      "Step 5: Verify input field remains empty"
    ],
    "passes": false
  },
  {
    "category": "functional",
    "description": "All filter shows all todos",
    "steps": [
      "Step 1: Navigate to http://localhost:5173",
      "Step 2: Add active and completed todos",
      "Step 3: Click 'All' filter",
      "Step 4: Verify all todos are visible"
    ],
    "passes": false
  },
  {
    "category": "functional",
    "description": "Completed filter shows only completed todos",
    "steps": [
      "Step 1: Navigate to http://localhost:5173",
      "Step 2: Add and complete some todos",
      "Step 3: Click 'Completed' filter",
      "Step 4: Verify only completed todos visible"
    ],
    "passes": false
  },
  {
    "category": "functional",
    "description": "Backend API GET /api/todos returns all todos",
    "steps": [
      "Step 1: Start the server",
      "Step 2: Add some todos via UI",
      "Step 3: Make GET request to http://localhost:3001/api/todos",
      "Step 4: Verify JSON response contains todos",
      "Step 5: Verify each todo has id, text, completed fields"
    ],
    "passes": false
  }
  // ... 10 more tests
]
```

### init.sh 内容

```bash
#!/bin/bash

echo "=================================="
echo "Simple Todo App - Setup & Run"
echo "=================================="

# Install frontend dependencies
echo "Installing frontend dependencies..."
npm install

# Install backend dependencies
echo "Installing backend dependencies..."
cd server && npm install && cd ..

# Start backend server
echo "Starting backend server on port 3001..."
cd server && node index.js &
BACKEND_PID=$!
cd ..

# Wait for backend to start
sleep 2

# Start frontend dev server
echo "Starting frontend dev server on port 5173..."
npm run dev &
FRONTEND_PID=$!

echo ""
echo "=================================="
echo "Application is running!"
echo "=================================="
echo ""
echo "Frontend: http://localhost:5173"
echo "Backend:  http://localhost:3001"
echo ""
echo "Press Ctrl+C to stop both servers"
echo ""

# Wait for interrupt
wait
```

---

## 第二次迭代：编码会话（5-10分钟）

### 启动输出

```
======================================================================
  SESSION 2: CODING AGENT
======================================================================

Sending prompt to Claude Agent SDK...
```

### Agent 恢复状态

```
[Tool: Bash]
   Input: {'command': 'pwd'}
   [Done]

I'm in /home/user/claude-quickstarts/autonomous-coding/test_todo_app

[Tool: Bash]
   Input: {'command': 'ls -la'}
   [Done]

[Tool: Bash]
   Input: {'command': 'cat app_spec.txt'}
   [Done]

Good, I understand this is a Simple Todo App project.

[Tool: Bash]
   Input: {'command': 'cat feature_list.json | head -50'}
   [Done]

I see 20 test cases, all currently marked as "passes": false.

[Tool: Bash]
   Input: {'command': 'cat claude-progress.txt'}
   [Done]

Previous session created the basic structure. Let me check git history:

[Tool: Bash]
   Input: {'command': 'git log --oneline -20'}
   [Done]

Output:
f3b8a2c Add basic server and React app structure
a1c4d5e Initial setup: feature_list.json, init.sh, and project structure

[Tool: Bash]
   Input: {'command': 'cat feature_list.json | grep \'"passes": false\' | wc -l'}
   [Done]

Output: 20

All 20 tests still need to be completed. Let me start the servers:

[Tool: Bash]
   Input: {'command': 'chmod +x init.sh && ./init.sh'}
   [Done]

Servers starting... Now let me verify the basic app works by testing in the browser.
```

### 验证现有功能

```
[Tool: mcp__puppeteer__puppeteer_navigate]
   Input: {'url': 'http://localhost:5173'}
   [Done]

[Tool: mcp__puppeteer__puppeteer_screenshot]
   [Done]

I can see the app loaded, but there are some issues:
- The input field exists but has no placeholder
- The Add button is visible
- No todos are displayed yet
- There are console errors about missing API endpoints

Let me implement the first feature completely: "User can add a new todo item"
```

### 实现第一个功能

```
[Tool: Edit]
   Input: {'file_path': 'server/index.js', 'old_string': '// TODO: implement routes', 'new_string': '...'}
   [Done]

Implemented the POST /api/todos endpoint.

[Tool: Edit]
   Input: {'file_path': 'src/App.jsx', 'old_string': 'const handleAddTodo = () => {', 'new_string': '...'}
   [Done]

Connected the Add button to call the backend API.

[Tool: Bash]
   Input: {'command': 'pkill node && cd server && node index.js &'}
   [Done]

Restarted the backend. Now let me test this feature end-to-end:

[Tool: mcp__puppeteer__puppeteer_navigate]
   Input: {'url': 'http://localhost:5173'}
   [Done]

[Tool: mcp__puppeteer__puppeteer_fill]
   Input: {'selector': 'input[type="text"]', 'value': 'Buy groceries'}
   [Done]

[Tool: mcp__puppeteer__puppeteer_click]
   Input: {'selector': 'button.add-button'}
   [Done]

[Tool: mcp__puppeteer__puppeteer_screenshot]
   [Done]

Perfect! I can see:
✓ "Buy groceries" appears in the todo list
✓ Input field is cleared
✓ No console errors

This feature is working correctly. Let me update feature_list.json:

[Tool: Edit]
   Input: {'file_path': 'feature_list.json', 'old_string': '...', 'new_string': '...'}
   [Done]

Marked test #1 as "passes": true

[Tool: Bash]
   Input: {'command': 'git add . && git commit -m "Implement add todo feature - verified end-to-end\n\n- Added POST /api/todos endpoint\n- Connected frontend form to backend\n- Tested with browser automation\n- Updated feature_list.json: marked test #1 as passing"'}
   [Done]
```

### 实现第二个功能

```
Now let me implement the second feature: "User can mark a todo as completed"

[Tool: Edit]
   Input: {'file_path': 'server/index.js', ...}
   [Done]

Added PUT /api/todos/:id endpoint.

[Tool: Edit]
   Input: {'file_path': 'src/components/TodoList.jsx', ...}
   [Done]

Added checkbox functionality with strikethrough styling.

Testing...

[Tool: mcp__puppeteer__puppeteer_navigate]
   Input: {'url': 'http://localhost:5173'}
   [Done]

[Tool: mcp__puppeteer__puppeteer_fill]
   Input: {'selector': 'input[type="text"]', 'value': 'Test task'}
   [Done]

[Tool: mcp__puppeteer__puppeteer_click]
   Input: {'selector': 'button.add-button'}
   [Done]

[Tool: mcp__puppeteer__puppeteer_click]
   Input: {'selector': 'input[type="checkbox"]'}
   [Done]

[Tool: mcp__puppeteer__puppeteer_screenshot]
   [Done]

Excellent! I can verify:
✓ Checkbox is checked
✓ Todo text has strikethrough decoration
✓ Completed count shows "1"
✓ Visual appearance matches requirements

[Tool: Edit]
   Input: {'file_path': 'feature_list.json', ...}
   [Done]

Marked test #2 as "passes": true

[Tool: Bash]
   Input: {'command': 'git add . && git commit -m "Implement toggle complete feature\n\n- Added PUT endpoint for updating todos\n- Added checkbox with strikethrough styling\n- Tested with browser automation\n- Updated feature_list.json: marked test #2 as passing"'}
   [Done]

[Tool: Write]
   Input: {'file_path': 'claude-progress.txt', ...}
   [Done]

Updated progress notes.

I've successfully implemented and verified 2 features in this session:
✓ Test #1: Add new todo
✓ Test #2: Mark todo as completed

18 tests remaining. The app is in a clean, working state.

----------------------------------------------------------------------
```

### 第二次迭代结束

```
Agent will auto-continue in 3s...

Progress: 2/20 tests passing (10.0%)

Reached max iterations (2)
To continue, run the script again without --max-iterations

======================================================================
  SESSION COMPLETE
======================================================================

Project directory: test_todo_app

Progress: 2/20 tests passing (10.0%)

----------------------------------------------------------------------
  TO RUN THE GENERATED APPLICATION:
----------------------------------------------------------------------

  cd /home/user/claude-quickstarts/autonomous-coding/test_todo_app
  ./init.sh           # Run the setup script
  # Or manually:
  npm install && npm run dev

  Then open http://localhost:5173 (or check init.sh for the URL)
----------------------------------------------------------------------

Done!
```

---

## Git 历史

```bash
$ git log --oneline

3f2c8d1 Implement toggle complete feature
a7e9b3c Implement add todo feature - verified end-to-end
f3b8a2c Add basic server and React app structure
a1c4d5e Initial setup: feature_list.json, init.sh, and project structure
```

---

## 更新后的 feature_list.json

```json
[
  {
    "category": "functional",
    "description": "User can add a new todo item",
    "steps": [...],
    "passes": true  // ✅ 已通过
  },
  {
    "category": "functional",
    "description": "User can mark a todo as completed",
    "steps": [...],
    "passes": true  // ✅ 已通过
  },
  {
    "category": "functional",
    "description": "User can delete a todo item",
    "steps": [...],
    "passes": false  // ⏳ 待实现
  },
  // ... 其余 17 个测试
]
```

---

## 继续运行

如果要继续完成剩余的 18 个测试：

```bash
# 移除 --max-iterations 限制
python3 autonomous_agent_demo.py --project-dir ./test_todo_app

# 或者继续几次迭代
python3 autonomous_agent_demo.py --project-dir ./test_todo_app --max-iterations 5
```

每次运行：
- Agent 从 feature_list.json 恢复状态
- 读取 claude-progress.txt 了解历史
- 实现 1-2 个新功能
- 验证并提交
- 更新进度

---

## 关键观察点

### 1. 无状态恢复
每次会话 Agent 都通过读取文件完全恢复状态：
```bash
cat app_spec.txt          # 了解项目目标
cat feature_list.json     # 查看进度
cat claude-progress.txt   # 读取历史笔记
git log                   # 检查提交历史
```

### 2. 浏览器自动化验证
所有功能都通过真实浏览器测试：
- `puppeteer_navigate` - 导航到页面
- `puppeteer_fill` - 填充表单
- `puppeteer_click` - 点击按钮
- `puppeteer_screenshot` - 截图验证

### 3. 安全沙箱
所有 bash 命令都经过白名单验证：
```
[Tool: Bash]
   Input: {'command': 'rm -rf /'}
   [BLOCKED] Command 'rm' is not in the allowed commands list
```

### 4. 进度透明
随时可以检查进度：
```bash
$ cat feature_list.json | jq '[.[] | select(.passes == true)] | length'
2

$ cat feature_list.json | jq 'length'
20
```

---

## 预期完成时间

基于 20 个测试用例：

- **初始化**：3-5 分钟（生成测试用例和项目结构）
- **每次编码会话**：5-10 分钟（实现 1-2 个功能）
- **总计**：约 10-15 次会话 = 1.5-3 小时

如果使用原始的 200 个测试用例：
- 预计需要 **10-20 小时**完成全部功能

---

## 故障排查

### 问题：Agent 没有启动服务器
**解决**：手动运行 `./init.sh`

### 问题：Browser automation 失败
**解决**：确保 Puppeteer MCP server 已安装
```bash
npm install -g puppeteer-mcp-server
```

### 问题：命令被 security hook 阻止
**解决**：检查 `security.py` 的 `ALLOWED_COMMANDS`

### 问题：想暂停并稍后继续
**操作**：
1. 按 `Ctrl+C` 停止
2. 稍后运行相同命令即可从断点继续

---

## 总结

Autonomous Coding Agent 展示了：

✅ **长期自主运行** - 通过多会话迭代完成大型项目
✅ **状态持久化** - 文件系统 + Git 作为"记忆"
✅ **真实测试** - 浏览器自动化确保功能可用
✅ **安全隔离** - 三层安全防护
✅ **进度可见** - 随时了解完成状态
✅ **可中断恢复** - 随时暂停，随时继续

这是一个生产级的 AI 自主开发演示系统！
