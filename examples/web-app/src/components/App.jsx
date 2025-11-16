import React from 'react';
import '../App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>Web App Example</h1>
        <p>Claude Workflow Pro with GitHub Integration</p>

        <div className="features">
          <h2>Features Demonstrated:</h2>
          <ul>
            <li>✅ GitHub issue integration</li>
            <li>✅ Development workflow commands</li>
            <li>✅ Auto checkpoints</li>
            <li>✅ Custom hooks (commit validation)</li>
            <li>✅ Session logging</li>
          </ul>
        </div>

        <div className="quick-start">
          <h2>Quick Start:</h2>
          <pre>
            {`claude /github/start-from-issue <number>
claude /workflow/create-plan "feature name"
claude /dev/local-review
claude /github/describe-pr`}
          </pre>
        </div>
      </header>
    </div>
  );
}

export default App;
