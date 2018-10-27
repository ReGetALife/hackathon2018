import React from 'react'
import { Router, Route, Switch } from 'react-router'
import createBrowserHistory from 'history/createBrowserHistory'
import Home from './containers/Home'
import Diary from './containers/Diary'
import Find from './containers/Find'
import List from './containers/List'
import Promises from './containers/Promise'
import Secret from './containers/Secret'
import World from './containers/World'
import Dates from './containers/Date'

const history = createBrowserHistory()

const router = App => (
  <Router history={history}>
    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/diary" exact component={Diary} />
      <Route path="/find" exact component={Find} />
      <Route path="/list" exact component={List} />
      <Route path="/promise" exact component={Promises} />
      <Route path="/secret" exact component={Secret} />
      <Route path="/world" exact component={World} />
      <Route path="/date" exact component={Dates} />
    </Switch>
  </Router>
)

export default router
