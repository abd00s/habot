##

### URL

```
/goals
```

### Method

```
GET
```

### URL Parameters

URL params are represented as JSON for legibility
```

{
  "controller": "goals",
  "action": "index"
}
```

### Data Parameters

```
NONE
```

### Success Response

#### Status

200

#### Body

```
[
  {
    "id": 90,
    "user_id": 163,
    "title": "Sample Goal",
    "frequency": 3,
    "period": "week",
    "created_at": "2019-04-10T19:25:37.000Z",
    "updated_at": "2019-04-10T19:25:37.000Z"
  }
]
```
